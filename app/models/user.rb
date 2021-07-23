class User < ApplicationRecord
    has_many :posts
    has_many :favorites, dependent: :destroy
    has_many :favorite_users, through: :favorites, source: :user
    has_secure_password
    before_validation {email.downcase!}
    mount_uploader :image, ImageUploader
    validates :name, presence: true, length: {maximum: 30}
    validates :email, presence: true, uniqueness: true, length: {maximum: 255}, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i  }
    validates :password, presence: true, length: {minimum:6}
   
end
