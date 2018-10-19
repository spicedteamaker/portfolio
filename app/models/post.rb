class Post < ApplicationRecord
  belongs_to :user
  paginates_per 5
  validates :title, presence: true
  validates :body, presence: true
  has_one_attached :main_picture # one-to-many relationship
  validate :check_uploaded_image
  validate :validate_attachment_type

  # FIXME This doesn't work, make it validate the image upload

  private
  def check_uploaded_image
    unless main_picture.attached?
      errors.add(:post, "must have an image attached")
    end
  end

  def validate_attachment_type
    accepted = [".gif", ".png", ".jpg", ".jpeg"]
    if main_picture.attached?
      extension = File.extname(main_picture.filename.to_s).downcase
      unless accepted.include? extension
        errors.add(:post, "only allows [.jpg, .gif, .png, .jpeg] file types")
      end
    end
  end
end
