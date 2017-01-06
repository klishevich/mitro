class Product < ApplicationRecord
  mount_uploader :img, ImgUploader
  belongs_to :category
  validates :category_id, presence: true
  validates :price, presence: true
  has_many :order_items
end
