class PosterClientsController < ApplicationController
  # before_filter :authenticate_admin, only: [:index_adm, :new, :create, :edit, :update]

  # def show
  # 	@user = current_user
  #   @poster_client = @user.poster_client
  # end

  def new
  	@user = current_user
    if (@user&.poster_client)
      @poster_client = @user.poster_client
      redirect_to edit_poster_client_path @poster_client
    else
      @poster_client = @user&.build_poster_client
      # default values
      @poster_client.client_sex = 0
      @poster_client.country = 'Russia'
      @poster_client.city = 'Moscow'
    end
  end

  def create
  	@user = current_user
    @poster_client = @user&.build_poster_client(poster_client_params)
    if @poster_client.save
      flash[:notice] = t(:poster_card_odered_successfuly)
      redirect_to edit_poster_client_path @poster_client
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
    	redirect_to edit_poster_client_path @poster_client
    else
    	render 'edit'
    end
  end 

  def poster_info
  	@user = current_user
    @poster_client = @user&.poster_client
  end

  private

  def poster_client_params
    params.require(:poster_client).permit(:client_name, :client_sex, :phone, :country, :city, :birthday )
  end 
end
