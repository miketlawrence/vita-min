# == Schema Information
#
# Table name: intakes
#
#  id                                                   :bigint           not null, primary key
#  additional_info                                      :string
#  adopted_child                                        :integer          default(0), not null
#  already_applied_for_stimulus                         :integer          default(0), not null
#  already_filed                                        :integer          default(0), not null
#  balance_pay_from_bank                                :integer          default(0), not null
#  bank_account_type                                    :integer          default("unfilled"), not null
#  bought_energy_efficient_items                        :integer
#  bought_health_insurance                              :integer          default(0), not null
#  city                                                 :string
#  claimed_by_another                                   :integer          default(0), not null
#  completed_at                                         :datetime
#  completed_yes_no_questions_at                        :datetime
#  continued_at_capacity                                :boolean          default(FALSE)
#  current_step                                         :string
#  demographic_disability                               :integer          default(0), not null
#  demographic_english_conversation                     :integer          default(0), not null
#  demographic_english_reading                          :integer          default(0), not null
#  demographic_primary_american_indian_alaska_native    :boolean
#  demographic_primary_asian                            :boolean
#  demographic_primary_black_african_american           :boolean
#  demographic_primary_ethnicity                        :integer          default(0), not null
#  demographic_primary_native_hawaiian_pacific_islander :boolean
#  demographic_primary_prefer_not_to_answer_race        :boolean
#  demographic_primary_white                            :boolean
#  demographic_questions_opt_in                         :integer          default(0), not null
#  demographic_spouse_american_indian_alaska_native     :boolean
#  demographic_spouse_asian                             :boolean
#  demographic_spouse_black_african_american            :boolean
#  demographic_spouse_ethnicity                         :integer          default(0), not null
#  demographic_spouse_native_hawaiian_pacific_islander  :boolean
#  demographic_spouse_prefer_not_to_answer_race         :boolean
#  demographic_spouse_white                             :boolean
#  demographic_veteran                                  :integer          default(0), not null
#  divorced                                             :integer          default(0), not null
#  divorced_year                                        :string
#  eip_only                                             :boolean
#  email_address                                        :citext
#  email_notification_opt_in                            :integer          default("unfilled"), not null
#  encrypted_bank_account_number                        :string
#  encrypted_bank_account_number_iv                     :string
#  encrypted_bank_name                                  :string
#  encrypted_bank_name_iv                               :string
#  encrypted_bank_routing_number                        :string
#  encrypted_bank_routing_number_iv                     :string
#  encrypted_primary_last_four_ssn                      :string
#  encrypted_primary_last_four_ssn_iv                   :string
#  encrypted_spouse_last_four_ssn                       :string
#  encrypted_spouse_last_four_ssn_iv                    :string
#  ever_married                                         :integer          default(0), not null
#  ever_owned_home                                      :integer          default(0), not null
#  feedback                                             :string
#  feeling_about_taxes                                  :integer          default(0), not null
#  filing_for_stimulus                                  :integer          default(0), not null
#  filing_joint                                         :integer          default(0), not null
#  final_info                                           :string
#  had_asset_sale_income                                :integer          default(0), not null
#  had_debt_forgiven                                    :integer          default(0), not null
#  had_dependents                                       :integer          default(0), not null
#  had_disability                                       :integer          default(0), not null
#  had_disability_income                                :integer          default(0), not null
#  had_disaster_loss                                    :integer          default(0), not null
#  had_farm_income                                      :integer          default(0), not null
#  had_gambling_income                                  :integer          default(0), not null
#  had_hsa                                              :integer          default(0), not null
#  had_interest_income                                  :integer          default(0), not null
#  had_local_tax_refund                                 :integer          default(0), not null
#  had_other_income                                     :integer          default(0), not null
#  had_rental_income                                    :integer          default(0), not null
#  had_retirement_income                                :integer          default(0), not null
#  had_self_employment_income                           :integer          default(0), not null
#  had_social_security_income                           :integer          default(0), not null
#  had_social_security_or_retirement                    :integer          default(0), not null
#  had_student_in_family                                :integer          default(0), not null
#  had_tax_credit_disallowed                            :integer          default(0), not null
#  had_tips                                             :integer          default(0), not null
#  had_unemployment_income                              :integer          default(0), not null
#  had_wages                                            :integer          default(0), not null
#  income_over_limit                                    :integer          default(0), not null
#  interview_timing_preference                          :string
#  issued_identity_pin                                  :integer          default(0), not null
#  job_count                                            :integer
#  lived_with_spouse                                    :integer          default(0), not null
#  locale                                               :string
#  made_estimated_tax_payments                          :integer          default(0), not null
#  married                                              :integer          default(0), not null
#  multiple_states                                      :integer          default(0), not null
#  needs_help_2016                                      :integer          default(0), not null
#  needs_help_2017                                      :integer          default(0), not null
#  needs_help_2018                                      :integer          default(0), not null
#  needs_help_2019                                      :integer          default(0), not null
#  needs_help_2020                                      :integer          default(0), not null
#  no_eligibility_checks_apply                          :integer          default(0), not null
#  no_ssn                                               :integer          default(0), not null
#  other_income_types                                   :string
#  paid_alimony                                         :integer          default(0), not null
#  paid_charitable_contributions                        :integer          default(0), not null
#  paid_dependent_care                                  :integer          default(0), not null
#  paid_local_tax                                       :integer          default(0), not null
#  paid_medical_expenses                                :integer          default(0), not null
#  paid_mortgage_interest                               :integer          default(0), not null
#  paid_retirement_contributions                        :integer          default(0), not null
#  paid_school_supplies                                 :integer          default(0), not null
#  paid_student_loan_interest                           :integer          default(0), not null
#  phone_number                                         :string
#  phone_number_can_receive_texts                       :integer          default(0), not null
#  preferred_interview_language                         :string
#  preferred_name                                       :string
#  primary_birth_date                                   :date
#  primary_consented_to_service                         :integer          default(0), not null
#  primary_consented_to_service_at                      :datetime
#  primary_consented_to_service_ip                      :inet
#  primary_first_name                                   :string
#  primary_last_name                                    :string
#  received_alimony                                     :integer          default(0), not null
#  received_homebuyer_credit                            :integer          default(0), not null
#  received_irs_letter                                  :integer          default(0), not null
#  received_stimulus_payment                            :integer          default(0), not null
#  referrer                                             :string
#  refund_payment_method                                :integer          default(0), not null
#  reported_asset_sale_loss                             :integer          default(0), not null
#  reported_self_employment_loss                        :integer          default(0), not null
#  requested_docs_token                                 :string
#  requested_docs_token_created_at                      :datetime
#  routed_at                                            :datetime
#  routing_criteria                                     :string
#  routing_value                                        :string
#  satisfaction_face                                    :integer          default(0), not null
#  savings_purchase_bond                                :integer          default(0), not null
#  savings_split_refund                                 :integer          default(0), not null
#  separated                                            :integer          default(0), not null
#  separated_year                                       :string
#  signature_method                                     :integer          default("online"), not null
#  sms_notification_opt_in                              :integer          default("unfilled"), not null
#  sms_phone_number                                     :string
#  sold_a_home                                          :integer          default(0), not null
#  sold_assets                                          :integer          default(0), not null
#  source                                               :string
#  spouse_auth_token                                    :string
#  spouse_birth_date                                    :date
#  spouse_consented_to_service                          :integer          default(0), not null
#  sold_a_home                                          :integer          default("unfilled"), not null
#  sold_assets                                          :integer          default("unfilled"), not null
#  source                                               :string
#  spouse_auth_token                                    :string
#  spouse_consented_to_service_at                       :datetime
#  spouse_consented_to_service_ip                       :inet
#  spouse_email_address                                 :citext
#  spouse_first_name                                    :string
#  spouse_had_disability                                :integer          default(0), not null
#  spouse_issued_identity_pin                           :integer          default(0), not null
#  spouse_last_name                                     :string
#  spouse_was_blind                                     :integer          default(0), not null
#  spouse_was_full_time_student                         :integer          default(0), not null
#  spouse_was_on_visa                                   :integer          default(0), not null
#  state                                                :string
#  state_of_residence                                   :string
#  street_address                                       :string
#  timezone                                             :string
#  triage_source_type                                   :string
#  type                                                 :string
#  viewed_at_capacity                                   :boolean          default(FALSE)
#  vita_partner_name                                    :string
#  wants_to_itemize                                     :integer          default(0), not null
#  was_blind                                            :integer          default(0), not null
#  was_full_time_student                                :integer          default(0), not null
#  was_on_visa                                          :integer          default(0), not null
#  widowed                                              :integer          default(0), not null
#  widowed_year                                         :string
#  with_general_navigator                               :boolean          default(FALSE)
#  with_incarcerated_navigator                          :boolean          default(FALSE)
#  with_limited_english_navigator                       :boolean          default(FALSE)
#  with_unhoused_navigator                              :boolean          default(FALSE)
#  zip_code                                             :string
#  created_at                                           :datetime
#  updated_at                                           :datetime
#  client_id                                            :bigint
#  triage_source_id                                     :bigint
#  visitor_id                                           :string
#  vita_partner_id                                      :bigint
#
# Indexes
#
#  index_intakes_on_client_id                                (client_id)
#  index_intakes_on_email_address                            (email_address)
#  index_intakes_on_phone_number                             (phone_number)
#  index_intakes_on_sms_phone_number                         (sms_phone_number)
#  index_intakes_on_triage_source_type_and_triage_source_id  (triage_source_type,triage_source_id)
#  index_intakes_on_vita_partner_id                          (vita_partner_id)
#
# Foreign Keys
#
#  fk_rails_...  (client_id => clients.id)
#  fk_rails_...  (vita_partner_id => vita_partners.id)
#
class Intake::CtcIntake < Intake

  def document_types_definitely_needed
    []
  end
end
