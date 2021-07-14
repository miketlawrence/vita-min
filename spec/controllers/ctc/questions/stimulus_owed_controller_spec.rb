require "rails_helper"

describe Ctc::Questions::StimulusOwedController do
  let(:intake) { create :ctc_intake }

  before do
    sign_in intake.client
  end

  describe "#update" do
    it "saves claim as the owed_stimulus_money and redirects to placeholder" do
      post :update

      expect(intake.reload.recovery_rebate_credit_amount_1).to eq 0
      expect(response).to redirect_to questions_stimulus_two_path
    end

    # how to name the column?
    # owed_stimulus_money: "claim"/"dont_claim"
    # claim_owed_stimulus_money: "yes"/no <-- like this one


  end
end
