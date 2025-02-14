module Hub
  class CreateCtcClientForm < ClientForm
    include BirthDateHelper
    set_attributes_for :intake,
                       :primary_first_name,
                       :primary_last_name,
                       :primary_birth_date_month,
                       :primary_birth_date_day,
                       :primary_birth_date_year,
                       :spouse_birth_date_month,
                       :spouse_birth_date_day,
                       :spouse_birth_date_year,
                       :preferred_name,
                       :preferred_interview_language,
                       :email_address,
                       :phone_number,
                       :sms_phone_number,
                       :street_address,
                       :city,
                       :state,
                       :state_of_residence,
                       :zip_code,
                       :primary_ssn,
                       :spouse_ssn,
                       :sms_notification_opt_in,
                       :email_notification_opt_in,
                       :spouse_first_name,
                       :spouse_last_name,
                       :spouse_email_address,
                       :interview_timing_preference,
                       :timezone,
                       :vita_partner_id,
                       :signature_method,
                       :with_general_navigator,
                       :with_incarcerated_navigator,
                       :with_limited_english_navigator,
                       :with_unhoused_navigator,
                       :with_drivers_license_photo_id,
                       :with_passport_photo_id,
                       :with_other_state_photo_id,
                       :with_vita_approved_photo_id,
                       :with_social_security_taxpayer_id,
                       :with_itin_taxpayer_id,
                       :with_vita_approved_taxpayer_id,
                       :recovery_rebate_credit_amount_1,
                       :recovery_rebate_credit_amount_2,
                       :recovery_rebate_credit_amount_confidence,
                       :refund_payment_method,
                       :navigator_name,
                       :navigator_has_verified_client_identity,
                       :primary_ip_pin,
                       :spouse_ip_pin
    set_attributes_for :tax_return,
                       :filing_status,
                       :filing_status_note
    set_attributes_for :confirmation,
                       :account_number_confirmation,
                       :routing_number_confirmation,
                       :primary_ssn_confirmation,
                       :spouse_ssn_confirmation
    set_attributes_for :bank_account,
                       :routing_number,
                       :account_number,
                       :bank_name,
                       :account_type
    attr_accessor :client

    before_validation do
      [primary_ssn, primary_ssn_confirmation, spouse_ssn, spouse_ssn_confirmation].each do |field|
        field.remove!(/\D/) if field
      end
    end

    # See parent ClientForm for additional validations.
    validates :vita_partner_id, presence: true, allow_blank: false
    validates :signature_method, presence: true
    validates :filing_status, presence: true
    after_save :send_confirmation_message, :send_mixpanel_data, :add_system_note

    validates :refund_payment_method, presence: true
    validates :navigator_name, presence: true
    validates :navigator_has_verified_client_identity, inclusion: { in: [true, '1'], message: I18n.t('errors.messages.blank') }

    with_options if: -> { refund_payment_method == "direct_deposit" } do
      validates_confirmation_of :routing_number
      validates_confirmation_of :account_number
      validates_presence_of :bank_name
      validates_presence_of :account_type
      validates_presence_of :account_number
      validates_presence_of :routing_number
    end

    validates_presence_of :account_number_confirmation, if: :account_number
    validates_presence_of :routing_number_confirmation, if: :routing_number

    validates_confirmation_of :primary_ssn
    validates_presence_of :primary_ssn_confirmation, if: :primary_ssn
    validates_presence_of :spouse_ssn_confirmation, if: :spouse_ssn
    validates :primary_ssn, social_security_number: true

    with_options if: -> { filing_status == "married_filing_jointly" } do
      validates_confirmation_of :spouse_ssn
      validates :spouse_ssn, social_security_number: true
    end

    validates :primary_ip_pin, format: { with: /\d{6}/, message: "Must be a 6 digit number."}, if: :primary_ip_pin
    validates :spouse_ip_pin, format: { with: /\d{6}/, message: "Must be a 6 digit number."}, if: :spouse_ip_pin

    validate :at_least_one_photo_id_type_selected
    validate :at_least_one_taxpayer_id_type_selected
    validate :valid_primary_birth_date
    validate :valid_spouse_birth_date, if: -> { filing_status == "married_filing_jointly" }

    def save(current_user)
      @current_user = current_user
      run_callbacks :save do
        return false unless valid?

        intake_attr = attributes_for(:intake)
                      .except(:primary_birth_date_year, :primary_birth_date_month, :primary_birth_date_day,
                              :spouse_birth_date_year, :spouse_birth_date_month, :spouse_birth_date_day)
                      .merge(
                        default_attributes,
                        bank_account_attributes: attributes_for(:bank_account),
                        dependents_attributes: formatted_dependents_attributes,
                        primary_birth_date: parse_birth_date_params(primary_birth_date_year, primary_birth_date_month, primary_birth_date_day),
                        spouse_birth_date: parse_birth_date_params(spouse_birth_date_year, spouse_birth_date_month, spouse_birth_date_day),
                        visitor_id: SecureRandom.hex(26))
        @client = Client.create!(
          vita_partner_id: attributes_for(:intake)[:vita_partner_id],
          intake_attributes: intake_attr,
          tax_returns_attributes: [tax_return_attributes]
        )
      end
    end

    private

    def send_confirmation_message
      locale = client.intake.preferred_interview_language == "es" ? "es" : "en"

      ClientMessagingService.send_system_message_to_all_opted_in_contact_methods(
        client: client,
        message: AutomatedMessage::SuccessfulSubmissionDropOff.new,
        locale: locale
      )
    end

    def send_mixpanel_data
      client.tax_returns.each do |tax_return|
        MixpanelService.send_event(
          event_id: @client.intake.visitor_id,
          event_name: "drop_off_submitted",
          data: MixpanelService.data_from([client, tax_return, @current_user])
        )
      end
    end

    def add_system_note
      SystemNote::VerifiedClientIdentity.generate!(client: @client)
    end

    def default_attributes
      {
          type: "Intake::CtcIntake",
          primary_last_four_ssn: primary_ssn&.last(4),
          spouse_last_four_ssn: spouse_ssn&.last(4),
      }
    end

    def tax_return_attributes
      {
        year: 2020,
        is_ctc: true,
        certification_level: :basic,
        status: :prep_ready_for_prep,
        service_type: :drop_off
      }.merge(attributes_for(:tax_return))
    end

    def at_least_one_photo_id_type_selected
      photo_id_selected = Intake::CtcIntake::PHOTO_ID_TYPES.any? do |_, type|
        self.send(type[:field_name]) == "1"
      end

      errors.add(:photo_id_type, I18n.t("hub.clients.fields.photo_id.error")) unless photo_id_selected
    end

    def at_least_one_taxpayer_id_type_selected
      taxpayer_id_selected = Intake::CtcIntake::TAXPAYER_ID_TYPES.any? do |_, type|
        self.send(type[:field_name]) == "1"
      end

      errors.add(:taxpayer_id_type, I18n.t("hub.clients.fields.taxpayer_id.error")) unless taxpayer_id_selected
    end
  end
end
