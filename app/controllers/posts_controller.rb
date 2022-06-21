class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  # before_action :contributor_confirmation, only: [:edit, :update, :destroy]

  def index
    @post = Post.all.order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
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
    @comment = Comment.new
    @comments = @post.comments
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to posts_path
    else
      redirect_to posts_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:address, :spring_quality, :description, :image, :latitude,
                                 :longitude).merge(user_id: current_user.id)
  end

   def contributor_confirmation
     if @post.user.id == current_user.id
       redirect_to posts_path
     else
       redirect_to posts_path
     end
   end
end
