class UserService
  include UsersHelper

  attr_accessor :session

  def initialize(user_params, reset_session, session)
    @user_params = user_params
    @reset_session = reset_session
    @session = session
  end

  def create_user
    record_creation = false
    error_message = nil
    begin
      user = User.new(@user_params)
      user.save!
      @reset_session
      log_in user
      record_creation = true
    rescue ActiveRecord::RecordInvalid => e
      error_message = e.message
    end
    { record_creation: record_creation, error_message: error_message }
  end
end
