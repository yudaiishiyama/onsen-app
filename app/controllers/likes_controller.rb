class LikesController < ApplicationController

  def create
    # logger.debug("geocode")
    post = Post.find(params[:post_id])
    # logger.debug("geocode end")
    @like = Like.create(user_id: current_user.id, post_id: post.id)
  end

  def destroy
    # logger.debug("geocode")
    post = Post.find(params[:post_id])
    logger.debug("geocode")
    @like=Like.find_by(user_id: current_user.id, post_id: post.id)
    logger.debug("geocode end")
    @like.destroy
  end
end
