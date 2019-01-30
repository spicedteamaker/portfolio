class PortfolioPost < ApplicationRecord
  has_one_attached :picture
  validates :title, presence: true
  validates :picture, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']


  # FIXME doesn't work at all
  # validate :validate_mime_type

  private

  def validate_mime_type
    tmpDirFile = "/var/tmp/magick-verification"
    unless pictures.nil?
      pictures.each do |p|
        url = "http://localhost:3000" + Rails.application.routes.url_helpers.rails_blob_path(p, only_path: true)
        IO.copy_stream(open(url), tmpDirFile)
        image = MiniMagick::Image.new(tmpDirFile)
        unless image.valid?
          errors.add(:portfolio_post, "only allows valid image files. Are you sure you're uploading a real image?")
          return false
        end
      end
    end
  end
end
