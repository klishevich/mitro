class Order < ApplicationRecord
	belongs_to :order_status
	belongs_to :user, optional: true
	has_many :order_items
	before_create :set_order_status

	def order_placed
		self.order_status_id = 2
	end

	private
	def set_order_status
		self.order_status_id = 1
	end

end
