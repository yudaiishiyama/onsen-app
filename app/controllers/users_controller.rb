class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if current_user == @user
      if @user.update(user_params)
        flash[:success] = 'プロフィール画像を変更しました'
        render :show
      else
        flash.now[:danger] = 'プロフィール画像の変更に失敗しました'
        render :show
      end
    else
      redirect_to user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:image)
  end
end
