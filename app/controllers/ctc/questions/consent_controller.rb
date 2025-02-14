module Ctc
  module Questions
    class ConsentController < QuestionsController
      include AnonymousIntakeConcern

      layout "intake"

      def update
        super
      end

      private

      def next_path
        questions_placeholder_question_path # replace with 2020 tax return question
      end

      def illustration_path
        nil
      end
    end
  end
end