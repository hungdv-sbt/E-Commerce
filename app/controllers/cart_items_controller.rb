class CartItemsController < ApplicationController
  before_action :list_cart_items, only: %i[index update_quantity destroy]
  before_action :cart_item, only: %i[update_quantity destroy]

  def index
    @total_price = total_price
  end

  def create
    @cart = current_user.cart || Cart.create(user: current_user)
    @cart_item = @cart.cart_items.find_or_initialize_by(product_id: params[:product_id])
    @cart_item.quantity.nil? ? @cart_item.quantity = params[:quantity].to_i : @cart_item.quantity += params[:quantity].to_i

    return render json: { error: 'not save' }, status: :bad_request unless @cart_item.save

    render json: { cart: @cart.cart_items.count }, status: :ok
  end

  def update_quantity
    return render json: { error: 'not found' }, status: :not_found if @cart_item.blank?

    if params[:quantity] == 'remove'
      @cart_item.quantity -= 1 if cart_item.quantity > 1
    else
      @cart_item.quantity += 1
    end

    @cart_item.save
    @total_price = total_price
    body_html = render_to_string(:show_list_item, layout: false)
    render json: { cart_items: body_html, total_price: @total_price }, status: :ok
  end

  def destroy
    return render json: { error: 'destroy error' }, status: :bad_request unless @cart_item.destroy

    count = @cart_items.count
    @total_price = total_price.to_i
    body_html = render_to_string(:show_list_item, layout: false)
    render json: { cart_items: body_html, count: count, total_price: @total_price }, status: :ok
  end

  private

  def list_cart_items
    @cart_items = current_user.cart.cart_items.includes(:product).order(id: :desc)
  end

  def cart_item
    @cart_item = current_user.cart.cart_items.find_by(id: params[:cart_item_id])
  end

  def total_price
    arr_price = current_user.cart.cart_items.map{ |cart| cart.quantity * cart.product.price }

    arr_price.inject{ |sum, price| sum += price }
  end
end
