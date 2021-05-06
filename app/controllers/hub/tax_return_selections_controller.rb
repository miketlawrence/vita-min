module Hub
  class TaxReturnSelectionsController < ApplicationController
    include AccessControllable
    include ClientSortable

    layout "admin"

    before_action :require_sign_in, :load_vita_partners, :load_users
    before_action :load_selection, only: [:show, :bulk_action]

    ALLOWED_ACTION_TYPES = ["change-organization", "send-a-message"]

    def create
      action_type = create_params[:action_type]

      return head 404 unless ALLOWED_ACTION_TYPES.include? action_type

      selection = TaxReturnSelection.create!(tax_returns: TaxReturn.accessible_by(current_ability).where(id: create_params[:tr_ids]))

      case action_type
      when "change-organization"
        redirect_to hub_bulk_actions_edit_change_organization_path(tax_return_selection_id: selection.id)
      when "send-a-message"
        redirect_to hub_bulk_actions_edit_send_a_message_path(tax_return_selection_id: selection.id)
      else
        head 404
      end
    end

    def new
      @client_count = Client.accessible_by(current_ability).distinct.joins(:tax_returns).where(tax_returns: { id: new_params[:tr_ids] }).count
      @selection = TaxReturnSelection.new
      @tr_ids = new_params[:tr_ids]
    end

    def show
      @client_filter_form_path = hub_clients_path
      @clients = @selection.clients.accessible_by(current_ability)
      @client_index_help_text = I18n.t("hub.tax_return_selections.help_text", count: @clients.size)
      inaccessible_client_count = @selection.clients.where.not(id: @clients).size
      @missing_results_message = I18n.t("hub.tax_return_selections.help_text_missing_results", count: inaccessible_client_count) unless inaccessible_client_count.zero?

      @clients = filtered_and_sorted_clients.page(params[:page])
      @page_title = I18n.t("hub.tax_return_selections.page_title", count: @selection.clients.size, id: @selection.id)

      render "hub/clients/index"
    end

    private

    def filter_cookie_name; end

    def load_selection
      @selection = TaxReturnSelection.find(params[:id])
    end

    def create_params
      params.require(:create_tax_return_selection).permit(:action_type, tr_ids: [])
    end

    def new_params
      params.permit(tr_ids: [])
    end
  end
end