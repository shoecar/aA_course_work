class SessionsController < ApplicationController
  def create
    user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )

    if user
      user.reset_session_token!
      session[:session_token] = user.session_token
      redirect_to :root
    else
      flash.now[:errors] = ["Invalid username or password"]
      user = User.new(user_name: params[:user][:user_name])
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end

  def destroy
    self.current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to :root
  end


end
