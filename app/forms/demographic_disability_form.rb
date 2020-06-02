class DemographicDisabilityForm < QuestionsForm
  set_attributes_for :intake, :demographic_disability
  validates_presence_of :demographic_disability, message: I18n.t("forms.validators.answer_presence")

  def save
    @intake.update(attributes_for(:intake))
  end
end