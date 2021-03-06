class PostsController < ApplicationController

  before_action :authenticate_user!,  only: [:create]
  before_action :set_post, only: [:show, :edit, :update, :destroy]


  def index
    #@posts = Post.search(params[:search]).paginate(:page => params[:page]).order_asc
    @posts = Post.search(params[:search], params[:page]).order_asc
  end

  def edit
  end


  def new
    @post = Post.new
  end

  def create

    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      redirect_to 'new'
    end
  end

  def import
    Post.import(params[:file], current_user)
    redirect_to root_url, notice: "Import saved"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:body, :title, :image, :file)
  end

end
