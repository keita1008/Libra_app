class User < ApplicationRecord
  has_secure_password
  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}
  # mount_uploader :image_name, ImageUploader
  def books
    return Book.where(user_id: self.id)
  end
end
