class OrderItem < ApplicationRecord
	belongs_to :order
	belongs_to :product

	validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
	validate :product_present
	validate :order_present

	private
	def product_present
		if product.nil?
			errors.add(:product, "is not valid.")
		end
	end

	def order_present
		if order.nil?
			errors.add(:order, "is not a valid order.")
		end
	end
end
