class ChildTaxCreditCalculator

  def self.monthly_payment_due(dependents_under_six_count:, dependents_over_six_count:)
    dependents_under_six_payment = dependents_under_six_count * 600
    dependents_over_six_payment = dependents_over_six_count * 250

    dependents_under_six_payment + dependents_over_six_payment
  end

  def self.total_payment_due(dependents_under_six_count:, dependents_over_six_count:)
    monthly_payment_due(dependents_under_six_count: dependents_under_six_count, dependents_over_six_count: dependents_over_six_count) * 12
  end

end
