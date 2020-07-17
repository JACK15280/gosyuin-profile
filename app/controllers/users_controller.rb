class UsersController < ApplicationController

  def show
    # @groups = Group.all
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path, notice: 'ユーザー情報が更新されました'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to root_path, notice: '退会完了'
    else
      flash.now[:alert] = '処理が実行出来ませんでした。'
      render :show
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
