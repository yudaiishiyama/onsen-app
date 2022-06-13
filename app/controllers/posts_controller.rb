class PostsController < ApplicationController
  def index
    @post = Post.all.order("created_at DESC")
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

  def edit
    @post = Post.find(params[:id])
    if @post.user.id == current_user.id 
    else
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    post = Post.find(params[:id])
    if post.user.id == current_user.id
      post.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end 

  private
  def post_params
    params.require(:post).permit(:address, :spring_quality, :description, :image, :latitude, :longitude).merge(user_id: current_user.id)
  end
end
