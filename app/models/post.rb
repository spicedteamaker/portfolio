class Post < ApplicationRecord
  belongs_to :user
  paginates_per 5
  validates :title, presence: true
  validates :body, presence: true
  has_one_attached :main_picture # one-to-many relationship
  validate :check_uploaded_image
  validate :validate_attachment_type
  validate :validate_mime_type

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

  def validate_mime_type
    tmpDirFile = "/var/tmp/magick-verification"
    url = "http://localhost:3000" + Rails.application.routes.url_helpers.rails_blob_path(main_picture, only_path: true)
    IO.copy_stream(open(url), tmpDirFile)
    image = MiniMagick::Image.new(tmpDirFile)
    unless image.valid?
      errors.add(:header_image, "only allows valid image files. Are you sure you're uploading a real image?")
      return false
    end
  end
end
