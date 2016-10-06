class UsersController < ApplicationController
  before_action :verify_logged_in_status

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end

  def verify_logged_in_status
    if current_user.session_token == session[:session_token]
      flash[:error] = "You're already logged in!"
      redirect_to cats_url
    end
  end

end
