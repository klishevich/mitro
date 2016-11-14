class PosterClient < ApplicationRecord
  belongs_to :user
  validates :client_name, presence: true
  validates :phone, presence: true
end
