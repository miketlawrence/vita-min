require "rails_helper"

describe Ctc::Questions::EmailAddressController do
  let(:visitor_id) { "asdfasdfa" }
  let(:client) { create :client, intake: (create :ctc_intake, visitor_id: visitor_id) }
  let(:intake) { client.intake }

  before do
    allow(subject).to receive(:current_intake).and_return(intake)
    allow(MixpanelService).to receive(:send_event)
  end

  it_behaves_like :a_question_where_an_intake_is_required, CtcQuestionNavigation

  describe "#edit" do
    it "renders edit template and initializes form" do
      get :edit, params: {}
      expect(response).to render_template :edit
      expect(assigns(:form)).to be_an_instance_of Ctc::EmailAddressForm
      expect(assigns(:form).intake).to be_an_instance_of Intake::CtcIntake
    end
  end

  describe "#update" do
    let(:params) do
      {
          ctc_email_address_form: {
              email_address: "email@example.com",
              email_address_confirmation: "email@example.com"
          }
      }
    end

    it "saves email address and updates notification preference" do
      get :update, params: params
      intake = Intake.last
      expect(assigns(:form).intake).to be_valid
      expect(intake.email_address).to eq "email@example.com"
      expect(intake.email_notification_opt_in_yes?).to be true
      expect(response).to redirect_to questions_verification_path
    end

    it "sends an event to mixpanel without the email address data" do
      post :update, params: params

      expect(MixpanelService).to have_received(:send_event).with(hash_including(
                                                                   event_name: "question_answered",
                                                                   data: {}
                                                                 ))
    end

    it "enqueues a job to send a verification code" do
      expect {
        post :update, params: params
      }.to have_enqueued_job(RequestVerificationCodeEmailJob).with(hash_including(
                                                                     email_address: "email@example.com",
                                                                     locale: :en,
                                                                     visitor_id: visitor_id,
                                                                     service_type: :ctc,
                                                                     client_id: client.id
                                                                   ))
    end
  end
end