class UsersController < ApplicationController
  def show
    @user  = User.find(params[:id])
    @post = Post.all
    @post =  @user.post
  end
end
