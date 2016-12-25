class Product < ApplicationRecord
  mount_uploader :img, ImgUploader
  belongs_to :category
end
