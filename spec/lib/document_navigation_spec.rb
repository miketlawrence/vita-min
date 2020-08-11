require "rails_helper"

RSpec.describe DocumentNavigation do
  before(:each) do
    class BaseController
      def self.show?(_)
        true
      end

      def current_intake; end
    end

    class FirstController < BaseController
      def self.document_type_key
        "Doc-1"
      end
    end

    class SecondController < BaseController
      def self.document_type_key
        "Doc-2"
      end
    end

    class SignpostController < BaseController
      def self.document_type_key
        nil
      end
    end

    class ThirdController < BaseController
      def self.document_type_key
        "Doc-3"
      end
    end

    class ExternalController; end

    stub_const("DocumentNavigation::FLOW", [
      FirstController,
      SecondController,
      SignpostController,
      ThirdController,
    ])
  end

  describe ".controllers" do
    it "returns the ordered controllers" do
      expect(described_class.controllers).to match_array(
        [
           FirstController,
           SecondController,
           SignpostController,
           ThirdController,
        ],
      )
    end
  end

  describe ".first" do
    it "delegates to .controllers" do
      expect(described_class.first).to eq(FirstController)
    end
  end

  describe ".first_for_intake" do
    let(:intake) { build :intake }
    before do
      allow(FirstController).to receive(:show?).with(intake).and_return(false)
    end

    it "returns the first relevant controller for the given input" do
      expect(described_class.first_for_intake(intake)).to eq SecondController
    end
  end
end
