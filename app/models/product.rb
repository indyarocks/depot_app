class Product < ActiveRecord::Base
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {with: /\.(gif|png|jpg|jpeg)\Z/i,
                                                    message: 'must be a URL for GIF, PNG, JPG or JPEG image.'}
end
