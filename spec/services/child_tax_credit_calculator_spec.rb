require "rails_helper"

describe ChildTaxCreditCalculator do
  describe ".monthly_payment_due" do
    it "should return the correct payment amount based on dependent counts" do
      monthly_payment_amount = described_class.monthly_payment_due(dependents_under_six_count: 1, dependents_over_six_count: 1)
      expect(monthly_payment_amount).to eq(850)
    end
  end

  describe ".total_payment_due" do
    it "should return the correct payment amount based on dependent counts" do
      total_payment_amount = described_class.total_payment_due(dependents_under_six_count: 1, dependents_over_six_count: 1)
      expect(total_payment_amount).to eq(10200)
    end
  end
end
