module Ctc
  module Questions
    class StimulusPaymentsController < QuestionsController
      # TODO: Transition to Authenticated once we log in client
      include AnonymousIntakeConcern

      layout "intake"

      def next_path
        questions_stimulus_received_path
      end

      private

      def illustration_path
        "hand-holding-check.svg"
      end
    end
  end
end