class ApplicationController < ActionController::Base
  before_action :set_notifications, if: :current_user
  before_action :nav_categories
  before_action :set_query

  def is_admin!
    redirect_to root_path, alert: "You are authorized to do that" unless current_user.admin?
  end

  def set_query
    @query = Post.ransack(params[:q])
  end

  private

  def set_notifications
    @notifications = current_user.notifications.includes(:event).newest_first.limit(9)
    @unread = @notifications.unread
    @read = @notifications.read
  end

  def nav_categories
    @nav_categories ||= Category.where(display_in_nav: true).order(:name)
  end
end
