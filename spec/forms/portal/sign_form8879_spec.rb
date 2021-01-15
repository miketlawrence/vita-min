require 'rails_helper'
RSpec::Matchers.define_negated_matcher :not_change, :change

describe Portal::SignForm8879 do
  subject { described_class.new(tax_return, params) }

  let(:fake_ip) { IPAddr.new }
  let(:params) { {} }
  context "when there is no form 8879 available on the tax return to sign" do
    it "raises an error" do
      expect { subject }.to raise_error StandardError
    end
  end

  context "#sign" do
    let(:document_service_double) { double }
    let(:client) { create :client, intake: (create :intake, primary_first_name: "Primary", primary_last_name: "Taxpayer") }
    let(:tax_return) { create :tax_return, year: 2019, client: client }
    let!(:document) { create :document, document_type: DocumentTypes::Form8879.key, tax_return: tax_return, client: client, uploaded_by: (create :user) }
    let!(:request) { OpenStruct.new(remote_ip: fake_ip) }
    let(:params) { { primary_accepts_terms: 'yes', primary_confirms_identity: 'yes', ip: fake_ip } }

    before do
      allow(WriteToPdfDocumentService).to receive(:new).and_return document_service_double
      allow(document_service_double).to receive(:tempfile_output).and_return Tempfile.new
      allow(document_service_double).to receive(:write)
    end

    context "when primary_accepts_terms is no" do
      let(:params) { { primary_accepts_terms: 'no' } }

      it "adds an error to the field" do
        subject.sign
        expect(subject.errors[:primary_accepts_terms]).to be_present
      end
    end

    context "when primary_certifies identity is no" do
      let(:params) { { primary_accepts_terms: 'yes', primary_confirms_identity: 'no' } }
      it "adds an error to the field" do
        subject.sign
        expect(subject.errors.keys.first).to eq :primary_confirms_identity
      end
    end

    context "when the transaction is successful" do
      it "writes the primary taxpayers legal name to the document" do
        subject.sign
        expect(document_service_double).to have_received(:write).with(:primary_signature, "Primary Taxpayer")
      end

      it "writes today's date to the document, formatted mm/dd/yyyy" do
        subject.sign
        expect(document_service_double).to have_received(:write).with(:primary_signed_on, Date.today.strftime("%m/%d/%Y"))
      end

      it "creates a signed document for the tax return" do
        expect { subject.sign }.to change(tax_return.documents, :count).by 1
        new_doc = Document.last
        expect(new_doc.document_type).to eq "Form 8879 (Signed)"
        expect(new_doc.display_name).to eq "Taxpayer Signed 2019 8879"
      end

      it "saves the primary_signed_on date and primary_signed_ip to the tax return" do
        expect { subject.sign }.to change(tax_return, :primary_signed_at).and change(tax_return, :primary_signed_ip).to(fake_ip)
      end

      it "updates the tax return's client to needs_attention" do
        expect {
          subject.sign
        }.to change(tax_return.client, :needs_attention?).to(true)
      end

      it "updates the tax return's status to ready to file" do
        expect {
          subject.sign
        }.to change(tax_return, :status).to("file_ready_to_file")
      end

      it "returns true" do
        expect(subject.sign).to eq true
      end
    end

    context "when document creation fails" do
      before do
        allow(tax_return.documents).to receive(:create!).and_raise ActiveRecord::Rollback
      end

      it "does not update the other tax_return signature fields" do
        expect {
          subject.sign
          tax_return.reload
        }.to not_change(tax_return, :primary_signed_at).and not_change(tax_return, :primary_signed_ip)
      end

      it "adds an error to the form object" do
        subject.sign
        expect(subject.errors[:transaction_failed]).to be_present
      end
    end

    context "when tax_return update fails" do
      before do
        allow(tax_return).to receive(:save!).and_raise ActiveRecord::Rollback
      end

      it "does not save the document" do
        expect {
          subject.sign
          tax_return.reload
        }.to not_change(tax_return.documents, :count)
      end

      it "pushes an error to the form object" do
        subject.sign
        expect(subject.errors[:transaction_failed]).to be_present
      end
    end
  end
end