class ProductsController < ApplicationController

  # PUBLIC PAGES
  def index
    # @products = Product.all
  end

  def index_delivery
  	@products = Product.where("is_delivery = 't'")
    render 'index_filtered'
  end

  def index_sibirskaya
  	@products = Product.where("is_sibirskaya = 't'")
    render 'index_filtered'
  end

  def index_volochaevskaya
  	@products = Product.where("is_volochaevskaya = 't'")
    render 'index_filtered'
  end

  def index_foodtrack
  	@products = Product.where("is_foodtrack = 't'")
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
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = t(:product_saved_successfuly)
      redirect_to edit_product_path @product
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
    	redirect_to edit_product_path @product
    else
    	render 'edit'
    end
  end  

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :volume, :is_delivery, :is_sibirskaya,
      :is_volochaevskaya, :is_foodtrack)
  end  
end
