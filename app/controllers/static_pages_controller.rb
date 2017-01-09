class StaticPagesController < ApplicationController
  layout 'application_home', only: [:home]
  before_action :authenticate_admin, only: [:admin, :users_index_adm, :user_adm]
  
  def home
  end

  def news
  end

  def test_payment
  	@yandex_kassa_scid = ENV["yandex_kassa_scid"].to_s
  end

  # ADMIN actions
  def admin
  end

  def users_index_adm
    @users = User.all
  end

  def user_adm
    @user = User.find_by_id(params[:id])
  end

end
