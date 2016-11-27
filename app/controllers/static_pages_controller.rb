class StaticPagesController < ApplicationController
  layout 'application_home', only: [:home]
  before_filter :authenticate_admin, only: [:admin]
  
  def home
  end

  def admin
  end

end
