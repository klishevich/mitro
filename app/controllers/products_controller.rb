class ProductsController < ApplicationController
  before_filter :authenticate_admin, only: [:index_adm, :new, :create, :edit, :update, :destroy]

  # PUBLIC PAGES
  def index
    # @products = Product.all
  end

  def index_main
    @products = Product.where("is_main = 't'").order(:id)
    @menu_name = t(:menu_name_main)
    render 'index_filtered'
  end

  def index_foodtrack
  	@products = Product.where("is_foodtrack = 't'").order(:id)
    @menu_name = t(:menu_name_foodtrack)
    render 'index_filtered'
  end

  def index_delivery
    all_categories = Category.all.order(:order)
    @categories = all_categories.select { |cat| cat if cat.products.count > 0 }
  end

  def index_delivery_products
    category_id = params[:category_id]
    @category = Category.where("id = #{category_id}").first
    @products = Product.where("is_foodtrack = 't' and category_id = #{category_id}").order(:id)
    @order_item = current_order.order_items.new
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
      :img, :img_cache, :remove_img, :is_main, :category_id)
  end  
end
