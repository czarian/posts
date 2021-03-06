class CommentsController < ApplicationController
  def index
  end

  def create
     @comment = Comment.new(comment_params)
     @comment.user = current_user
     if @comment.save
      redirect_to post_path(@comment.post)
    else
      redirect_to posts_path
    end
  end



  private
  def comment_params
      params.require(:comment).permit(:body, :post_id)
    end
end
