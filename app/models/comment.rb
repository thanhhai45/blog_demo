class Comment < ApplicationRecord
  belongs_to :post, counter_cache: true
  belongs_to :user
  has_rich_text :body

  after_create_commit :notify_recipient
  before_destroy :cleanup_notification
  has_many :notification_mentions, as: :record, dependent: :destroy, class_name: 'Noticed::Event'

  private

  def notify_recipient
    CommentNotificationNotifier.with(record: self, post: post).deliver_later(post.user)
  end

  def cleanup_notification
    notification_as_comment.destroy_all
  end
end
