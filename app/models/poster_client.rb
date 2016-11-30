class PosterClient < ApplicationRecord
  belongs_to :user
  validates :client_name, presence: true
  validates :phone, presence: true

  def poster_clients_add
  	Rails.logger.info("3) class PosterClient poster_clients_add")
  	poster_int = PosterIntegration.new
  	res = poster_int.add_client(self.client_name, self.client_sex, self.phone, 
  		self.country, self.city, self.user.email, self.birthday)
  	Rails.logger.info("4) class PosterClient res #{res}")
  	self.poster_client_id = res
    self.is_active = true
  end

end
