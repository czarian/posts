class HomesController < ApplicationController
  def show
    @posts = Post.paginate(:page => params[:page]).order("created_at ASC")
  end
end
