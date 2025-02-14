module Ctc
  module Questions
    class EmailAddressController < QuestionsController
      include AnonymousIntakeConcern

      layout "intake"

      private

      def after_update_success
        RequestVerificationCodeEmailJob.perform_later(
          client_id: current_intake.client_id,
          email_address: current_intake.email_address,
          locale: I18n.locale,
          visitor_id: current_intake.visitor_id,
          service_type: :ctc
        )
      end

      def prev_path
        questions_contact_preference_path
      end

      def next_path
        questions_verification_path
      end
    end
  end
end