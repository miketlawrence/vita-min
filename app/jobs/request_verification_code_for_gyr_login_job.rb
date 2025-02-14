class RequestVerificationCodeForGyrLoginJob < ApplicationJob
  def perform(email_address: nil, phone_number: nil, locale:, visitor_id:)
    if email_address.present?
      if ClientLoginService.can_login_by_email_verification?(email_address)
        EmailVerificationCodeService.request_code(
          email_address: email_address,
          locale: locale,
          visitor_id: visitor_id,
          service_type: :gyr
        )
      else
        VerificationCodeMailer.no_match_found(
          to: email_address,
          locale: locale,
        ).deliver_now
      end
    end

    if phone_number.present?
      if ClientLoginService.can_login_by_sms_verification?(phone_number)
        TextMessageVerificationCodeService.request_code(
          phone_number: phone_number,
          locale: locale,
          visitor_id: visitor_id,
          service_type: :gyr
        )
      else
        home_url = Rails.application.routes.url_helpers.root_url(locale: locale)
        TwilioService.send_text_message(
          to: phone_number,
          body: I18n.t("verification_code_sms.no_match", locale: locale, home_url: home_url)
        )
      end
    end
  end
end