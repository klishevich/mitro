class Order < ApplicationRecord
	belongs_to :order_status
	belongs_to :user, optional: true
	has_many :order_items
	before_create :set_order_status

	def order_placed
		self.order_status_id = 2
	end

	def order_payed_yandex_kassa
		self.order_status_id = 5
	end

	def calc_total_sum
		sum = 0
		self.order_items.each do |item|
			sum += item.quantity * item.product.price
		end
		self.total_sum = sum
	end

	private
	def set_order_status
		self.order_status_id = 1
	end

end
