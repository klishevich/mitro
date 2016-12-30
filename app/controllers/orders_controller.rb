class OrdersController < ApplicationController
	before_filter :authenticate, only: [:show]
	def cart
		@order = current_order
		@order_items = @order.order_items
		# Rails.logger.info("cart current_porder #{current_porder}")
	end

	def update
		@order = Order.find(params[:id])
		@order.order_placed
		if @order.update_attributes(order_params)
			# flash[:success] = t(:saved_successfuly)
			session[:order_id] = nil
			redirect_to '/order_placed'
		else
			render 'cart'
		end
	end 

	def show
		@order = Order.find(params[:id])
	end

	def order_placed
	end

	def order_params
    	params.require(:order).permit(:person_name, :phone, :email, :comment,
      	order_items_attributes: [:id, :product_id, :quantity, :_destroy])
  	end
end
