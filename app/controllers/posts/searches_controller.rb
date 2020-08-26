class Posts::SearchesController < ApplicationController
  def index
    @posts = Post.search(params[:keyword]).includes(:user)
    @search_name = params[:keyword]
  end
end
