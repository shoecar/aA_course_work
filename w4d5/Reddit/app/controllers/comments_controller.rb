class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    render :new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to root_url
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :commentable_id, :commentable_type)
  end
end
