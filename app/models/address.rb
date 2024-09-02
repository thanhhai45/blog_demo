class Address < ApplicationRecord
  belongs_to :user

  validates :street, :state, :country, :city, :zip, presence: true
end
