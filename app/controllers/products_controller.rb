class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :admin?, only: %i[new edit update destroy]

  # GET /products or /products.json
  def index
    @products = Product.all.order(id: :desc)
  end

  # GET /products/1 or /products/1.json
  def show
    redirect_product_blank?(@product)
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    redirect_product_blank?(@product)
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to products_path, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    redirect_product_blank?(@product)

    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to products_path, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    redirect_product_blank?(@product)

    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_path, status: :see_other, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find_by(id: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :description, :price, images: [])
  end

  def admin?
    redirect_to root_path unless current_user&.admin?
  end

  def redirect_product_blank?(product)
    return redirect_to root_path if product.blank?
  end
end
