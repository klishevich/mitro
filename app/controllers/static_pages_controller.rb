class StaticPagesController < ApplicationController
  layout 'application_home', only: [:home]
  # before_action :authenticate_user!, :only => [:admin]
  
  def home
  end

  def admin
  end
end
