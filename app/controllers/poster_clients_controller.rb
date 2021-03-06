class PosterClientsController < ApplicationController
  before_action :authenticate_user!
  layout 'coupon_layout', only: [:coupon]

  def poster_info
  	@user = current_user
    @poster_client = @user&.poster_client
  end

  def bonus_info
    @user = current_user
    @poster_client = @user&.poster_client
  end

  def new
  	@user = current_user
    if (@user&.poster_client)
      @poster_client = @user.poster_client
      redirect_to poster_info_path
    else
      @poster_client = @user&.build_poster_client
      # default values
      @poster_client.client_sex = 0
      @poster_client.country = t(:default_country)
      @poster_client.city = t(:default_city)
    end
  end

  def create
  	@user = current_user
    Rails.logger.info("1) PosterClientsController start create")
    @poster_client = @user&.build_poster_client(poster_client_params)
    if @poster_client.valid?
      Rails.logger.info("2) PosterClientsController valid")
      @poster_client.poster_clients_add
      @poster_client.save
      Rails.logger.info("5) PosterClientsController finish")
      flash[:notice] = t(:poster_card_odered_successfuly)
      redirect_to poster_info_path
    else
      render 'new'
    end  
  end

  def edit
    @user = current_user
    @poster_client = @user&.poster_client
  end

  def update
  	@user = current_user
  	@poster_client = @user&.poster_client
    if @poster_client.update_attributes(poster_client_params)
    	flash[:notice] = t(:saved_successfuly)
    	redirect_to poster_info_path
    else
    	render 'edit'
    end
  end

  def coupon
    @user = current_user
    @poster_client = @user&.poster_client
    if (@poster_client&.has_bonus?)
      render 'coupon'
    else
      flash[:notice] = t(:no_bonus)
      redirect_to root_path
    end 
  end

  private

  def poster_client_params
    params.require(:poster_client).permit(:client_name, :client_sex, :phone, :country, :city, :birthday )
  end 
end
