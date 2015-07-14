class CommentsController < ApplicationController
  def index
    # byebug
    if params[:user_id]
      @user = User.find(params[:user_id])
      @comments = @user.comments
      render json: @comments
    else
      @contact = Contact.find(params[:contact_id])
      @comments = @contact.comments
      render json: @comments
    end
  end
end
