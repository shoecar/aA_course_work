class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:session][:name],
      params[:session][:password]
    )
    if @user
      log_in!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["log in again!"]
      render :new
    end
  end

  def destroy
    log_out!(current_user)
    redirect_to root_url
  end
end
