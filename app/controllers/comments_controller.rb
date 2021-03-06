class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    respond_to do |format|
      format.html { redirect_to post_path(params[:post_id]) }
      format.json
    end
    @comment_post = @comment.post
    @comment_post.create_notification_comment!(current_user, @comment.id)
  end

  def destroy
    post = Post.find(params[:post_id])
    @comment = Comment.find_by(id: params[:id], post_id: params[:post_id])
    @comment.destroy
    redirect_to post_path(post.id), notice: "コメントを削除しました"
  end
  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
