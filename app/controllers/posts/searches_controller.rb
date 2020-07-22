class Posts::SearchesController < ApplicationController
  def index
    @posts = Post.search(params[:keyword]).includes(:user)
  end
end
