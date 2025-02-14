require "rails_helper"

RSpec.describe FlowsController do
  describe '#show' do
    render_views

    context 'for the gyr flow' do
      it 'renders successfully' do
        get :show, params: { id: :gyr }

        expect(response.body).to have_content('GetYourRefund Flow')
      end
    end

    context 'for the ctc flow' do
      it 'renders successfully' do
        get :show, params: { id: :ctc }

        expect(response.body).to have_content('CTC Flow')
      end
    end

    context 'for a nonexistant flow' do
      it 'renders 404' do
        expect do
          get :show, params: { id: :aardvark }
        end.to raise_error(ActionController::RoutingError)
      end
    end
  end
end
