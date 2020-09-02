class CaseFilesController < ApplicationController
  include ZendeskAuthenticationControllerHelper

  before_action :require_zendesk_admin

  layout "admin"

  def create
    intake = Intake.find_by(id: params[:intake_id])
    return head 422 unless intake.present?

    created_case = CaseFile.create_from_intake(intake)
    redirect_to case_file_path(id: created_case.id)
  end

  def show
    @case_file = CaseFile.find(params[:id])
  end
end