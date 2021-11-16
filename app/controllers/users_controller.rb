class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :logged_in_user, only: [:show]
  before_action :correct_user,   only: %i[edit update]

  def index
    @users = User.paginate_users(params[:page])
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    new_user_created = UserService.new(user_params, reset_session, session).create_user
    if new_user_created[:record_creation] == true
      flash[:success] = 'Logged In Successfully!'
      redirect_to root_path
    else
      flash[:danger] = "Log In Not Successful #{new_user_created[:error_message]}"
      redirect_to new_user_path
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = 'User deleted'
    redirect_to users_url
  end

  def enter_log_in
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      forwarding_url = session[:forwarding_url]
      reset_session
      log_in @user
      redirect_to root_path
    else
      flash.now[:notice] = 'Invalid email/password combination'
      redirect_to new_user_path
    end
  end

  def logout
    log_out if logged_in?
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'Please log in.'
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
