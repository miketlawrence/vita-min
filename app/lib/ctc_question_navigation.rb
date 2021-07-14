class CtcQuestionNavigation
  include ControllerNavigation

  FLOW = [
    # Basic info
    Ctc::Questions::OverviewController,
    Ctc::Questions::PersonalInfoController,
    Ctc::Questions::ContactPreferenceController,
    Ctc::Questions::CellPhoneNumberController,
    Ctc::Questions::EmailAddressController,
    Ctc::Questions::VerificationController,
    Ctc::Questions::ConsentController,
    Ctc::Questions::PlaceholderQuestionController,

    # Filing status
    Ctc::Questions::FilingStatusController,
    Ctc::Questions::SpouseSsnController,

    # Bank and mailing info
    Ctc::Questions::RefundPaymentController,
    Ctc::Questions::DirectDepositController,
    Ctc::Questions::RoutingNumberController,
    Ctc::Questions::AccountNumberController,
    Ctc::Questions::ConfirmBankAccountController,
    Ctc::Questions::MailingAddressController,
    Ctc::Questions::ConfirmMailingAddressController,
    Ctc::Questions::IpPinController,
  ].freeze
end