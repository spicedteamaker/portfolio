class PortfolioPost < ApplicationRecord
  has_many_attached :pictures
  validates :title, presence: true
  validate :validate_pictures_attached
  validate :validate_attachment_type
  # FIXME doesn't work at all
  validate :validate_mime_type

  private
  def validate_pictures_attached
    if pictures.empty?
      errors.add(:portfolio_post, "must attach one or more images")
    end
  end
  def validate_attachment_type
    accepted = [".gif", ".png", ".jpg", ".jpeg"]
    unless pictures.nil?
      pictures.each do |p|
        extension = File.extname(p.filename.to_s).downcase
        unless accepted.include? extension
          errors.add(:portfolio_post, "only allows [.jpg, .gif, and .png] file types")
        end
      end
    end
  end

  def validate_mime_type
    unless pictures.nil?
      pictures.each do |p|
        url = "http://localhost:3000" + Rails.application.routes.url_helpers.rails_blob_path(p, only_path: true)
        image = MiniMagick::Image.new(url)
        unless image.valid?
          errors.add(:portfolio_post, "only allows valid image files. Are you sure you're uploading a real image?")
          return false
        end
      end
    end
  end
end
