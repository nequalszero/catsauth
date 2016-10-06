class SessionsController < ApplicationController
  skip_before_action :verify_logged_in_status, only: [:destroy]
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
    params[:user][:user_name],
    params[:user][:password]
    )

    if user.nil?
      redirect_to new_user_url
    else
      user.reset_session_token!
      login!(user)
      redirect_to cats_url
    end
  end

  def destroy
    return nil if current_user.nil?
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to cats_url
  end

  private
  def verify_logged_in_status
    if current_user.session_token == session[:session_token]
      flash[:error] = "You're already logged in!"
      redirect_to cats_url
    end
  end


end
