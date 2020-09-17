shared_examples :a_get_action_that_redirects_anonymous_users_to_sign_in do |action:|
  let(:params) { {} } unless method_defined?(:params)

  context "with an anonymous user" do
    it "saves the current path to the session and redirects to the zendesk login path" do
      get action, params: params

      expect(response).to redirect_to zendesk_sign_in_path
      expect(session[:after_login_path]).to be_present
    end
  end
end

shared_examples :a_post_action_that_redirects_anonymous_users_to_sign_in do |action:|
  let(:params) { {} } unless method_defined?(:params)

  context "with an anonymous user" do
    it "saves the current path to the session and redirects to the zendesk login path" do
      post action, params: params

      expect(response).to redirect_to zendesk_sign_in_path
      expect(session[:after_login_path]).to be_present
    end
  end
end

shared_examples :a_get_action_forbidden_to_non_admin_users do |action:|
  let(:params) { {} } unless method_defined?(:params)

  context "with a non-admin user" do
    before { sign_in( create :agent_user ) }

    it "saves the current path to the session and redirects to the zendesk login path" do
      get action, params: params

      expect(response.status).to eq 403
    end
  end
end

shared_examples :a_post_action_forbidden_to_non_admin_users do |action:|
  let(:params) { {} } unless method_defined?(:params)

  context "with a non-admin user" do
    before { sign_in( create :agent_user ) }

    it "saves the current path to the session and redirects to the zendesk login path" do
      post action, params: params

      expect(response.status).to eq 403
    end
  end
end