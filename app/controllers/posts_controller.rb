class PostsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  before_action :set_group

  def index
    @posts = Post.includes(:user).where(status: 1).order("updated_at DESC").page(params[:page]).per(5)
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

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      redirect_to post_path(post.id), notice: '御朱印の編集が完了しました'
    else
      flash.now[:alert] = '内容を入力してください。'
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      redirect_to root_path, notice: '御朱印を削除しました'
    else
      flash.now[:alert] = '削除できませんでした。'
      redirect_to post_path(params[:post_id])
    end
  end

  def search
    if params[:q].present?
      @search = Post.ransack(search_params)
    else
      params[:q] = { sorts: 'id desc' }
      @search = Post.ransack()
    end
    @posts = Post.search(params[:keyword]).where(status: 1).order("updated_at DESC").page(params[:page]).per(30)
    @search_name = params[:keyword]
    @search = Post.ransack(params[:q])
  end

  def again_search
    if params[:q].present?
      @search = Post.ransack(search_params)
    else
      params[:q] = { sorts: 'id desc' }
      @search = Post.ransack()
    end
    @search = Post.ransack(params[:q])
    @search_posts = @search.result(distinct: true).where(status: 1).order("updated_at DESC").page(params[:page]).per(30)
  end

  def post_all_page
    @posts = Post.includes(:user).order("updated_at DESC")
    @user = User.all
  end

  def no_nreleased
    @posts = Post.includes(:user).where(status: 2).order("updated_at DESC").page(params[:page]).per(30)
    @user = User.all
  end

  private
  def post_params
    params.require(:post).permit(:status, :title, :content, :image, group_ids: []).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def set_group
    @groups = Group.all
  end

  def search_params
    params.require(:q).permit(
        :sorts,
        :name_cont,
        :content_cont
      )
  end
end
