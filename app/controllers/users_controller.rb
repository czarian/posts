class UsersController < ApplicationController

  before_action :set_user, only: [:posts]

  def posts
    @posts = @user.post.page(params[:page]).order("created_at ASC")
  end

  def set_user
    @user = User.find(params[:id])
  end

end
