class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one  :address, dependent: :destroy, inverse_of: :user, autosave: true

  has_many :notifications, as: :recipient, dependent: :destroy, class_name: 'Noticed::Notification'
  has_many :notification_mentions, as: :record, dependent: :destroy, class_name: 'Noticed::Event'

  enum role: [:user, :admin]

  after_initialize :set_default_role, if: :new_record?

  cattr_accessor :form_steps do
    %w[sign_up set_name set_address find_users]
  end

  attr_accessor :form_step

  def form_step
    @form_step ||= 'sign_up'
  end

  with_options if: -> { required_for_step?('set_name') } do |step|
    step.validates :first_name, presence: true
    step.validates :last_name, presence: true
  end

  validates_associated :address, if: -> { required_for_step?('set_address') }

  accepts_nested_attributes_for :address, allow_destroy: true

  def required_for_step?(step)
    form_steps.nil?

    form_steps.index(step.to_s) <= form_steps.index(form_step.to_s)
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at email encrypted_password id first_name last_name
       remember_created_at reset_password_sent_at reset_password_token updated_at views]
  end

  def full_name
    return email if first_name.nil? || last_name.nil?

    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  private

  def set_default_role
    self.role ||= :user
  end
end
