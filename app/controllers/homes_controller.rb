class HomesController < ApplicationController
  def show
    @posts = Post.all(:page => params[:page]).order("created_at ASC")
  end
end
