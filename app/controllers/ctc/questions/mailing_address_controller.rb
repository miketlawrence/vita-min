module Ctc
  module Questions
    class MailingAddressController < QuestionsController
      # TODO: Transition to Authenticated once we log in client
      include AnonymousIntakeConcern

      layout "intake"
    end
  end
end