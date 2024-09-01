class AdminController < ApplicationController
  include Pagy::Backend
  def index
  end

  def posts
    @pagy, @posts = pagy(Post.all.includes(:user).order(created_at: :desc))
  end

  def comments
    @pagy, @comments = pagy(Comment.all.includes(:user, :rich_text_body).order(created_at: :desc))
  end

  def users
    @users = User.all
  end

  def show_post
    @post ||= Post.includes(:user, comments: [:user, :rich_text_body]).find(params[:id])
  end
end
