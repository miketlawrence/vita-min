require "rails_helper"

RSpec.describe OutgoingEmailMailer, type: :mailer do
  describe "#user_message" do
    let(:outgoing_email) do
      create :outgoing_email, subject: "Update from GetYourRefund", body: body.chomp
    end
    let(:body) do
      <<~BODY
        Line 1
        Line 2
      BODY
    end

    it "has the right subject and body" do
      email = OutgoingEmailMailer.user_message(outgoing_email: outgoing_email)
      expect do
        email.deliver_now
      end.to change(ActionMailer::Base.deliveries, :count).by 1
      expect(email.subject).to eq outgoing_email.subject
      expect(email.from).to eq ["no-reply@test.localhost"]
      expect(email.to).to eq [outgoing_email.client.email_address]
      expect(email.text_part.decoded.chomp).to eq body
      expect(email.html_part.decoded).to have_selector('div', text: "Line 1")
      expect(email.html_part.decoded).to have_selector('div', text: "Line 2")
    end
  end
end