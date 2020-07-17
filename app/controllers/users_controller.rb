class UsersController < ApplicationController

  def show
    @groups = Group.all
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    current_user.update(user_params)
    redirect_to root_path
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
