class Post < ApplicationRecord
  paginates_per 5
  validates :title, presence: true
  validates :body, presence: true
  has_one_attached :main_picture # one-to-many relationship
  validate :check_uploaded_image

  # FIXME This doesn't work, make it validate the image upload

  private
  def check_uploaded_image
    unless main_picture.attached?
      errors.add(:post, "must have an image attached")
    end
  end
end
