class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def new
    @posts = Post.all
    @groups = Group.all
    @group = Group.new
  end

  def create
    if Group.create(group_params)
      redirect_to root_path, notice: '新しいグループが作成できました'
    else
      flash.now[:alert] = '内容を入力してください。'
      render :new
    end
  end

  def show
    @groups = Group.all
    @group = Group.find(params[:id])
    @posts = @group.posts
  end

  def edit
    @posts = Post.all
    @group = Group.find(params[:id])
    @groups = Group.all
    
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group.id), notice: 'グループの編集が完了しました'
    else
      flash.now[:alert] = '内容を入力してください。'
      render :edit
    end
  end

  def destroy
    group = Group.find(params[:id])
    if group.destroy
      redirect_to root_path, notice: 'グループが削除されました'
    else
      flash.now[:alert] = '削除出来ませんでした。'
      render :edit
    end
  end


  private
  def group_params
    params.require(:group).permit(:name, post_ids: []).merge(user_id: current_user.id)
  end
end
