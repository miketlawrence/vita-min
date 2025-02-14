class DuplicateIntakeGuard < SimpleDelegator
  def has_duplicate?
    Intake
      .where(primary_consented_to_service: "yes")
      .where(
         (arel_table[:email_address].eq(email_address)
           .and(arel_table[:email_address].not_eq(nil)))
         .or(arel_table[:phone_number].eq(phone_number)
           .and(arel_table[:phone_number].not_eq(nil)))
      ).exists?
  end

  private

  def arel_table
    Intake.arel_table
  end
end
