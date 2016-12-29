class Product < ApplicationRecord
  mount_uploader :img, ImgUploader
  belongs_to :category
  has_many :order_items
end
