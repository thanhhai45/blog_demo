# frozen_string_literal: true

# Represents a blog post in the application
class Post < ApplicationRecord
  extend FriendlyId
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :notifications, through: :user
  has_rich_text :body
  has_one :content, class_name: 'ActionText::RichText', as: :record, dependent: :destroy

  validates :title, presence: true, length: { minimum: 5, maximum: 50 }
  validates :body, presence: true, length: { minimum: 10, maximum: 1000 }

  friendly_id :title, use: %i[slugged history finders]

  def self.ransackable_attributes(auth_object = nil)
    %w[content_body created_at id title updated_at user_id views category_id]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[comments notifications user category]
  end
  
  def should_generate_new_friendly_id?
    title_changed? || slug.blank?
  end
end
