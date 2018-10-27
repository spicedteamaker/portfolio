class Post < ApplicationRecord
  belongs_to :user
  paginates_per 5
  validates :title, presence: true
  validates :body, presence: true
  has_one_attached :main_picture # one-to-many relationship
  validates :main_picture, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']
  # validate :check_uploaded_image
  # validate :validate_attachment_type
  # validate :validate_mime_type

  private

  def validate_mime_type
    tmpDirFile = Rails.root + "tmp/temporary-images/magick-validation"
    url = "http://localhost:3000" + Rails.application.routes.url_helpers.rails_blob_path(main_picture, only_path: true)
    IO.copy_stream(open(url), tmpDirFile)
    image = MiniMagick::Image.new(tmpDirFile)
    unless image.valid?
      errors.add(:header_image, "only allows valid image files. Are you sure you're uploading a real image?")
      return false
    end
  end
end
