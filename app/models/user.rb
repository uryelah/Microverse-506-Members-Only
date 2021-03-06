# frozen_string_literal: true

class User < ApplicationRecord
  before_create :generate_token
  validates :name, presence: true, length: { maximum: 25 }, uniqueness: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true

  has_many :posts
  has_secure_password

  def generate_token
    self.remember_token = User.create_token
  end

  def self.create_token
    user_token = SecureRandom.urlsafe_base64
    Digest::SHA1.hexdigest user_token
  end
end
