# frozen_string_literal: true

# Represents a blog post in the application
class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :notifications, through: :user, dependent: :destroy

  validates :title, presence: true, length: { minimum: 5, maximum: 50 }
  validates :body, presence: true, length: { minimum: 10, maximum: 1000 }

  def self.ransackable_attributes(auth_object = nil)
    %w[body created_at id title updated_at user_id views]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["comments", "notifications", "user"]
  end
end
