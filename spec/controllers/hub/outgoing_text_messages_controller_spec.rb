require "rails_helper"

RSpec.describe Hub::OutgoingTextMessagesController do
  describe "#create" do
    let(:user) { create :user_with_membership }
    let(:vita_partner) { user.memberships.first.vita_partner }
    let(:client) { create :client, vita_partner: vita_partner, intake: create(:intake, sms_phone_number: "+15105551234", phone_number: "+15105551777") }
    let(:params) do
      {
          client_id: client.id,
          outgoing_text_message: {
              body: "This is an outgoing text"
          }
      }
    end

    it_behaves_like :a_post_action_for_authenticated_users_only, action: :create

    context "as an authenticated user" do
      before do
        sign_in user
        allow(ClientChannel).to receive(:broadcast_contact_record)
      end

      it "sends a text", active_job: true do
        expect {
          post :create, params: params
        }.to change(OutgoingTextMessage, :count).from(0).to(1)

        outgoing_text_message = OutgoingTextMessage.last
        expect(outgoing_text_message.body).to eq "This is an outgoing text"
        expect(outgoing_text_message.to_phone_number).to eq client.sms_phone_number
        expect(outgoing_text_message.client).to eq client
        expect(SendOutgoingTextMessageJob).to have_been_enqueued.with(outgoing_text_message.id)
        expect(response).to redirect_to(hub_client_messages_path(client_id: client.id))
      end

      it "sends a real-time update to anyone on this client's page" do
        post :create, params: params
        expect(ClientChannel).to have_received(:broadcast_contact_record).with(OutgoingTextMessage.last)
      end
    end
  end
end
