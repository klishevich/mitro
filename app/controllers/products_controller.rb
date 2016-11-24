class ProductsController < ApplicationController
  before_filter :authenticate_admin, only: [:index_adm, :new, :create, :edit, :update, :destroy]

  # PUBLIC PAGES
  def index
    # @products = Product.all
  end

  def index_main
    @products = Product.where("is_main = 't'")
    @menu_name = t(:menu_name_main)
    render 'index_filtered'
  end
  
  def index_delivery
  	@products = Product.where("is_delivery = 't'")
    @menu_name = t(:menu_name_delivery)
    render 'index_filtered'
  end

  def index_foodtrack
  	@products = Product.where("is_foodtrack = 't'")
    @menu_name = t(:menu_name_foodtrack)
    render 'index_filtered'
  end

  def show
    @product = Product.find(params[:id])  
  end

  # ADMIN PAGES
  def index_adm
    @products = Product.order(id: :desc)
    # self.index
    # render template: "products/index_adm" 
  end

  def new
    @product = Product.new
    @product.is_main = true
    @product.is_delivery = true
    @product.is_foodtrack = true
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = t(:product_saved_successfuly)
      # redirect_to edit_product_path @product
      redirect_to products_index_adm_path
    else
      render 'new'
    end  
  end

  def edit
    @product=Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
    	flash[:notice] = t(:product_saved_successfuly)
    	# redirect_to edit_product_path @product
      redirect_to products_index_adm_path
    else
    	render 'edit'
    end
  end

  def destroy
    @product=Product.find(params[:id])
    @product.destroy
    flash[:notice] = t(:product_deleted_successfuly)
    redirect_to products_index_adm_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :volume, :is_delivery, :is_foodtrack, 
      :img, :img_cache, :remove_img, :is_main)
  end  
end
