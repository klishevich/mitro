class OrdersController < ApplicationController
	before_action :authenticate, only: [:show]
	def cart
		@order = current_order
		@order_items = @order.order_items
		if user_signed_in? 
			@order.email = current_user.email
			if current_user.poster_client 
				@order.person_name = current_user.poster_client.client_name
				@order.phone = current_user.poster_client.phone
			end
		end
		# Rails.logger.info("cart current_porder #{current_porder}")
	end

	def update
		@order = Order.find(params[:id])
		@order.order_placed
		@order.calc_total_sum
		Rails.logger.info("OrdersController update @order #{@order.to_json}")
		if user_signed_in? 
			@order.user_id = current_user.id
		end
		if @order.update_attributes(order_params)
			flash[:notice] = t(:order_saved_successfuly)
			session[:order_id] = nil
			if @order.is_card_pay
				redirect_to "/card_pay/#{@order.id}"
			else
				redirect_to '/order_placed'
			end
		else
			render 'cart'
		end
	end

	def show
		@order = Order.find(params[:id])
	end

	def order_placed
	end

	def card_pay
		id = params[:id]
		@order = Order.where("id = #{id} and is_card_pay = 't' and order_status_id = 2").first
		if !@order 
			flash[:notice] = t(:order_not_found)
			redirect_to '/'
		end
		@yandex_kassa_scid = ENV["yandex_kassa_scid"].to_s
		# @customerNumber = @order.id
		# @sum = params[:total_sum]
	end

	def order_params
    	params.require(:order).permit(:person_name, :phone, :email, :comment, :user_id, :is_card_pay)
  	end
end
