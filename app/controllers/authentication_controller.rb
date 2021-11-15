class AuthenticationController < ApplicationController
  before_action :load_if_current_user_present?

  private

  def load_if_current_user_present?
    redirect_to login_path unless logged_in?
    true
  end
end
