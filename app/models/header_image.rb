class HeaderImage < ApplicationRecord
  has_one_attached :picture # one-to-many relationship
  validate :validate_mime_type

  def validate_mime_type
    url = "http://localhost:3000" + Rails.application.routes.url_helpers.rails_blob_path(picture, only_path: true)
    image = MiniMagick::Image.new(url)
    unless image.valid?
      errors.add(:portfolio_post, "only allows valid image files. Are you sure you're uploading a real image?")
      return false
    end
  end
end
