class OrderItemsController < ApplicationController
	def create
		@order = current_order
		Rails.logger.info("OrderItemsController create @order #{@order.to_json}")
		product_id = order_item_params[:product_id]
		if (@order.order_items.where(product_id: product_id).count == 0) 
			@order.order_items.new(order_item_params)
			@order.save(validate: false)
		end
		session[:order_id] = @order.id
	end

	def update
		@order = current_order
		@order_item = @order.order_items.find(params[:id])
		@order_item.update_attributes(order_item_params)
		@order_items = @order.order_items
		redirect_to cart_path
	end

	def destroy
		@order = current_order
		@order_item = @order.order_items.find(params[:id])
		@order_item.destroy
		@order_items = @order.order_items
		redirect_to cart_path
	end

	private
	def order_item_params
		params.require(:order_item).permit(:quantity, :product_id)
	end
end