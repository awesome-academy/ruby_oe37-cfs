module SpecTestHelper
  def login_user user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  def nil_session
    request.session[:user_id] = nil
  end
end
