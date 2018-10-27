class HeaderImage < ApplicationRecord
  has_one_attached :picture # one-to-many relationship
  validates :picture, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']

  # validate :validate_mime_type

  def validate_mime_type
    tmpDirFile = "/var/tmp/magick-verification"
    url = "http://localhost:3000" + Rails.application.routes.url_helpers.rails_blob_path(picture, only_path: true)
    IO.copy_stream(open(url), tmpDirFile)
    image = MiniMagick::Image.new(tmpDirFile)
    unless image.valid?
      errors.add(:header_image, "only allows valid image files. Are you sure you're uploading a real image?")
      return false
    end
  end
end
