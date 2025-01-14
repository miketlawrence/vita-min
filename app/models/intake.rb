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
#  email_address_verified_at                            :datetime
#  email_notification_opt_in                            :integer          default("unfilled"), not null
#  encrypted_bank_account_number                        :string
#  encrypted_bank_account_number_iv                     :string
#  encrypted_bank_name                                  :string
#  encrypted_bank_name_iv                               :string
#  encrypted_bank_routing_number                        :string
#  encrypted_bank_routing_number_iv                     :string
#  encrypted_primary_ip_pin                             :string
#  encrypted_primary_ip_pin_iv                          :string
#  encrypted_primary_last_four_ssn                      :string
#  encrypted_primary_last_four_ssn_iv                   :string
#  encrypted_primary_ssn                                :string
#  encrypted_primary_ssn_iv                             :string
#  encrypted_spouse_ip_pin                              :string
#  encrypted_spouse_ip_pin_iv                           :string
#  encrypted_spouse_last_four_ssn                       :string
#  encrypted_spouse_last_four_ssn_iv                    :string
#  encrypted_spouse_ssn                                 :string
#  encrypted_spouse_ssn_iv                              :string
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
#  navigator_has_verified_client_identity               :boolean
#  navigator_name                                       :string
#  needs_help_2016                                      :integer          default(0), not null
#  needs_help_2017                                      :integer          default(0), not null
#  needs_help_2018                                      :integer          default(0), not null
#  needs_help_2019                                      :integer          default(0), not null
#  needs_help_2020                                      :integer          default(0), not null
#  needs_to_flush_searchable_data_set_at                :datetime
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
#  primary_consented_to_service                         :integer          default("unfilled"), not null
#  primary_consented_to_service_at                      :datetime
#  primary_consented_to_service_ip                      :inet
#  primary_first_name                                   :string
#  primary_last_name                                    :string
#  primary_middle_initial                               :string
#  received_alimony                                     :integer          default(0), not null
#  received_homebuyer_credit                            :integer          default(0), not null
#  received_irs_letter                                  :integer          default(0), not null
#  received_stimulus_payment                            :integer          default(0), not null
#  recovery_rebate_credit_amount_1                      :integer
#  recovery_rebate_credit_amount_2                      :integer
#  recovery_rebate_credit_amount_confidence             :integer
#  referrer                                             :string
#  refund_payment_method                                :integer          default("unfilled"), not null
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
#  searchable_data                                      :tsvector
#  separated                                            :integer          default(0), not null
#  separated_year                                       :string
#  signature_method                                     :integer          default("online"), not null
#  sms_notification_opt_in                              :integer          default("unfilled"), not null
#  sms_phone_number                                     :string
#  sms_phone_number_verified_at                         :datetime
#  sold_a_home                                          :integer          default(0), not null
#  sold_assets                                          :integer          default(0), not null
#  source                                               :string
#  spouse_auth_token                                    :string
#  spouse_birth_date                                    :date
#  spouse_consented_to_service                          :integer          default(0), not null
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
#  street_address2                                      :string
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
#  bank_account_id                                      :bigint
#  client_id                                            :bigint
#  triage_source_id                                     :bigint
#  visitor_id                                           :string
#  vita_partner_id                                      :bigint
#  with_drivers_license_photo_id                        :boolean          default(FALSE)
#  with_itin_taxpayer_id                                :boolean          default(FALSE)
#  with_other_state_photo_id                            :boolean          default(FALSE)
#  with_passport_photo_id                               :boolean          default(FALSE)
#  with_social_security_taxpayer_id                     :boolean          default(FALSE)
#  with_vita_approved_photo_id                          :boolean          default(FALSE)
#  with_vita_approved_taxpayer_id                       :boolean          default(FALSE)
#
# Indexes
#
#  index_intakes_on_bank_account_id                          (bank_account_id)
#  index_intakes_on_client_id                                (client_id)
#  index_intakes_on_email_address                            (email_address)
#  index_intakes_on_needs_to_flush_searchable_data_set_at    (needs_to_flush_searchable_data_set_at) WHERE (needs_to_flush_searchable_data_set_at IS NOT NULL)
#  index_intakes_on_phone_number                             (phone_number)
#  index_intakes_on_searchable_data                          (searchable_data) USING gin
#  index_intakes_on_sms_phone_number                         (sms_phone_number)
#  index_intakes_on_triage_source_type_and_triage_source_id  (triage_source_type,triage_source_id)
#  index_intakes_on_type                                     (type)
#  index_intakes_on_vita_partner_id                          (vita_partner_id)
#
# Foreign Keys
#
#  fk_rails_...  (client_id => clients.id)
#  fk_rails_...  (vita_partner_id => vita_partners.id)
#

class Intake < ApplicationRecord
  include PgSearch::Model

  def self.searchable_fields
    [:client_id, :primary_first_name, :primary_last_name, :preferred_name, :spouse_first_name, :spouse_last_name, :email_address, :phone_number, :sms_phone_number]
  end

  pg_search_scope :search, against: searchable_fields, using: { tsearch: { prefix: true, tsvector_column: 'searchable_data' } }

  has_many :documents, dependent: :destroy
  has_many :documents_requests, dependent: :destroy
  has_many :dependents, -> { order(created_at: :asc) }, inverse_of: :intake, dependent: :destroy
  belongs_to :client, inverse_of: :intake, optional: true
  has_many :tax_returns, through: :client
  belongs_to :vita_partner, optional: true
  accepts_nested_attributes_for :dependents, allow_destroy: true
  scope :completed_yes_no_questions, -> { where.not(completed_yes_no_questions_at: nil) }

  validates :email_address, 'valid_email_2/email': true
  validates :phone_number, :sms_phone_number, allow_blank: true, e164_phone: true
  validates_presence_of :visitor_id
  before_save do
    self.needs_to_flush_searchable_data_set_at = Time.current
  end

  after_save do
    if saved_change_to_completed_at?(from: nil)
      InteractionTrackingService.record_incoming_interaction(client) # client completed intake
    elsif completed_at.present?
      InteractionTrackingService.record_internal_interaction(client) # user updated completed intake
    end
  end

  attr_encrypted :primary_last_four_ssn, key: ->(_) { EnvironmentCredentials.dig(:db_encryption_key) }
  attr_encrypted :spouse_last_four_ssn, key: ->(_) { EnvironmentCredentials.dig(:db_encryption_key) }
  attr_encrypted :primary_ssn, key: ->(_) { EnvironmentCredentials.dig(:db_encryption_key) }
  attr_encrypted :spouse_ssn, key: ->(_) { EnvironmentCredentials.dig(:db_encryption_key) }
  attr_encrypted :bank_name, key: ->(_) { EnvironmentCredentials.dig(:db_encryption_key) }
  attr_encrypted :bank_routing_number, key: ->(_) { EnvironmentCredentials.dig(:db_encryption_key) }
  attr_encrypted :bank_account_number, key: ->(_) { EnvironmentCredentials.dig(:db_encryption_key) }

  enum email_notification_opt_in: { unfilled: 0, yes: 1, no: 2 }, _prefix: :email_notification_opt_in
  enum sms_notification_opt_in: { unfilled: 0, yes: 1, no: 2 }, _prefix: :sms_notification_opt_in
  enum signature_method: { online: 0, in_person: 1 }, _prefix: :signature_method
  enum bank_account_type: { unfilled: 0, checking: 1, savings: 2, unspecified: 3 }, _prefix: :bank_account_type
  enum primary_consented_to_service: { unfilled: 0, yes: 1, no: 2 }, _prefix: :primary_consented_to_service
  enum refund_payment_method: { unfilled: 0, direct_deposit: 1, check: 2 }, _prefix: :refund_payment_method


  NAVIGATOR_TYPES = {
    general: {
      param: "1",
      display_name: "General",
      field_name: :with_general_navigator
    },
    incarcerated: {
      param: "2",
      display_name: "Incarcerated/reentry",
      field_name: :with_incarcerated_navigator
    },
    limited_english: {
      param: "3",
      display_name: "Limited English",
      field_name: :with_limited_english_navigator
    },
    unhoused: {
      param: "4",
      display_name: "Unhoused",
      field_name: :with_unhoused_navigator
    }
  }

  def is_ctc?
    false
  end

  # Returns the phone number formatted for user display, e.g.: "(510) 555-1234"
  def formatted_phone_number
    Phonelib.parse(phone_number).local_number
  end

  # Returns the sms phone number in the E164 standardized format, e.g.: "+15105551234"
  def standardized_sms_phone_number
    PhoneParser.normalize(sms_phone_number)
  end

  def primary_full_name
    "#{primary_first_name} #{primary_last_name}"
  end

  def spouse_full_name
    "#{spouse_first_name} #{spouse_last_name}"
  end

  def primary_user
    users.where.not(is_spouse: true).first
  end

  def spouse
    users.where(is_spouse: true).first
  end

  def consented?
    primary_consented_to_service_at.present?
  end

  def pdf
    IntakePdf.new(self).output_file
  end

  def consent_pdf
    ConsentPdf.new(self).output_file
  end

  def referrer_domain
    URI.parse(referrer).host if referrer.present?
  end

  def state_of_residence_name
    States.name_for_key(state_of_residence)
  end

  def tax_year
    2019
  end

  def had_a_job?
    job_count.present? && job_count > 0
  end

  def eligible_for_vita?
    # if any are unfilled this will return false
    had_farm_income_no? && had_rental_income_no? && income_over_limit_no?
  end

  def any_students?
    was_full_time_student_yes? ||
      spouse_was_full_time_student_yes? ||
      had_student_in_family_yes? ||
      dependents.where(was_student: "yes").any?
  end

  def spouse_name_or_placeholder
    return I18n.t("models.intake.your_spouse") unless spouse_first_name.present?
    spouse_full_name
  end

  def student_names
    names = []
    names << primary_full_name if was_full_time_student_yes?
    names << spouse_name_or_placeholder if spouse_was_full_time_student_yes?
    names += dependents.where(was_student: "yes").map(&:full_name)
    names
  end

  def external_id
    return unless id.present?

    ["intake", id].join("-")
  end

  def get_or_create_spouse_auth_token
    return spouse_auth_token if spouse_auth_token.present?

    new_token = SecureRandom.urlsafe_base64(8)
    update(spouse_auth_token: new_token)
    new_token
  end

  def most_recent_filing_year
    filing_years.first || 2020
  end

  def filing_years
    tax_returns.pluck(:year).sort.reverse
  end

  def filer_count
    filing_joint_yes? ? 2 : 1
  end

  def include_bank_details?
    refund_payment_method_direct_deposit? || balance_pay_from_bank_yes?
  end

  def year_before_most_recent_filing_year
    most_recent_filing_year && most_recent_filing_year - 1
  end

  def contact_info_filtered_by_preferences
    contact_info = {}
    contact_info[:sms_phone_number] = sms_phone_number if sms_notification_opt_in_yes?
    contact_info[:email] = email_address if email_notification_opt_in_yes?
    contact_info
  end

  def opted_into_notifications?
    sms_notification_opt_in_yes? || email_notification_opt_in_yes?
  end

  def age_end_of_tax_year
    return unless primary_birth_date.present?

    tax_year - primary_birth_date.year
  end

  def spouse_age_end_of_tax_year
    return unless spouse_birth_date.present?

    tax_year - spouse_birth_date.year
  end

  ##
  # advances all tax returns to a new status, only if the new status is more advanced.
  # Earlier or equal statuses will be ignored.
  #
  # @param [String] new_status: the name of the status to advance to
  #
  def advance_tax_return_statuses_to(new_status)
    client.tax_returns.each do |tax_return|
      tax_return.advance_to(new_status)
    end
  end

  def had_earned_income?
    had_a_job? || had_wages_yes? || had_self_employment_income_yes?
  end

  def had_dependents_under?(yrs)
    dependents.any? { |dependent| dependent.age_at_end_of_tax_year < yrs }
  end

  def needs_help_with_backtaxes?
    needs_help_2019_yes? || needs_help_2018_yes? || needs_help_2017_yes? || needs_help_2016_yes?
  end

  def formatted_contact_preferences
    text = "Prefers notifications by:\n"
    text << "    • Text message\n" if sms_notification_opt_in_yes?
    text << "    • Email\n" if email_notification_opt_in_yes?
    text
  end

  def formatted_mailing_address
    return "N/A" unless street_address
    <<~ADDRESS
      #{street_address}
      #{city}, #{state} #{zip_code}
    ADDRESS
  end
  
  def update_or_create_13614c_document(filename)
    ClientPdfDocument.create_or_update(
      output_file: pdf,
      document_type: DocumentTypes::Form13614C,
      client: client,
      filename: filename
    )
  end

  def update_or_create_14446_document(filename)
    ClientPdfDocument.create_or_update(
      output_file: consent_pdf,
      document_type: DocumentTypes::Form14446,
      client: client,
      filename: filename
    )
  end

  def update_or_create_additional_consent_pdf
    ClientPdfDocument.create_or_update(
      output_file: AdditionalConsentPdf.new(client).output_file,
      document_type: DocumentTypes::AdditionalConsentForm,
      client: client,
      filename: "additional-consent-2021.pdf"
    )
  end

  def might_encounter_delayed_service?
    vita_partner.at_capacity?
  end

  def set_navigator(param)
    _, navigator_type = NAVIGATOR_TYPES.find { | _, type| type[:param] == param }
    return unless navigator_type

    self.update(navigator_type[:field_name] => true)
  end

  def navigator_display_names
    names = []
    NAVIGATOR_TYPES.each do |_, type|
      if self.send(type[:field_name])
        names << type[:display_name]
      end
    end
    names.join(', ')
  end

  def self.refresh_search_index(limit: 10_000)
    now = Time.current
    ids = where('needs_to_flush_searchable_data_set_at < ?', now)
      .limit(limit)
      .pluck(:id)

    where(id: ids)
      .where('needs_to_flush_searchable_data_set_at < ?', now)
      .update_all(<<-SQL)
        searchable_data = to_tsvector('simple', array_to_string(ARRAY[#{searchable_fields.map { |f| "#{f}::text"}.join(",\n") }], ' ', '')),
        needs_to_flush_searchable_data_set_at = NULL
      SQL
  end
end
