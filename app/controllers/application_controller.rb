class ApplicationController < ActionController::Base
  before_action :set_notifications, if: :current_user
  before_action :set_query

  private
  
  def set_query
    @query = Post.ransack(params[:q])
  end

  def set_notifications
    @notifications = current_user.notifications.newest_first.limit(9)
    @unread = @notifications.unread
    @read = @notifications.read

  end
end
