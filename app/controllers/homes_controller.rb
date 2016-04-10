class HomesController < ApplicationController
  def show
    @posts = Post.paginate(:page => params[:page]).order_asc
  end
end
