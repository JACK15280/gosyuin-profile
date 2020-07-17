class PostsController < ApplicationController

  def index
    @posts = Post.includes(:user)
  end

  def new
    @post = Post.new
  end

  def create
    if Post.create(post_params)
      redirect_to root_path, notice: '御朱印が投稿されました'
    else
      flash.now[:alert] = '内容を入力してください。'
      render :new
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :image).merge(user_id: current_user.id)
  end
end
