# To deliver this notification:
#
# CommentNotificationNotifier.with(record: @post, message: "New post").deliver(User.all)

class CommentNotificationNotifier < ApplicationNotifier
  # Add your delivery methods
  #
  # deliver_by :email do |config|
  #   config.mailer = "UserMailer"
  #   config.method = "new_post"
  # end
  #
  # bulk_deliver_by :slack do |config|
  #   config.url = -> { Rails.application.credentials.slack_webhook_url }
  # end
  #
  # deliver_by :custom do |config|
  #   config.class = "MyDeliveryMethod"
  # end

  # Add required params
  #
  # required_param :message

  notification_methods do
    # I18n helpers
    def message
      "#{recipient.email} commented on #{params[:post][:title]}"
    end

    # URL helpers are accessible in notifications
    # Don't forget to set your default_url_options so Rails knows how to generate urls
    def url
      post_path(Post.find(params[:post][:id]))
    end
  end
end
