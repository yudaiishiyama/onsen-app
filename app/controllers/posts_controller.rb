class PostsController < ApplicationController
  def index
    @post = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post=Post.new(post_params)
    if @post.save
      redirect_to root_path(post_params)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private
  def post_params
    params.require(:post).permit(:address, :spring_quality, :description, :image, :latitude, :longitude).merge(user_id: current_user.id)
  end
end
