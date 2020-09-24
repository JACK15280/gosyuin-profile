class FavoritesController < ApplicationController
  before_action :set_post
  before_action :authenticate_user!

  def create
    if @post.user_id != current_user.id
      @favorite = Favorite.create(user_id: current_user.id, post_id: @post.id)
    end

    if @favorite.save
      redirect_to post_path(params[:post_id]), notice: 'お気に入りに登録しました'
    else
      flash[:alert] = "保存できていません"
      redirect_to post_path(params[:post_id])
    end
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, post_id: @post.id)
    if @favorite.destroy
      redirect_to post_path(params[:post_id]), notice: 'お気に入りから削除しました'
    else
      flash[:alert] = "削除できていません"
      redirect_to post_path(params[:post_id])
    end
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end
end
