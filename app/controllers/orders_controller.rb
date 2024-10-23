class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.where.not(total_price: nil).order(id: :desc)
  end

  def create
    @cart = current_user.cart
    return render json: { error: 'not_found' }, status: :not_found if @cart.cart_items.blank?

    @order = Order.create(user: current_user)

    @cart.cart_items.each do |cart_item|
      @order.order_items.build(
        product: cart_item.product,
        quantity: cart_item.quantity
      )
    end

    @order.total_price = params[:total_price]
    return render json: {}, status: :bad_request unless @order.save

    @cart.cart_items.destroy_all
    render json: {}, status: :ok
  end

  def order_product
    @order = Order.create(user: current_user, total_price: params[:total_price])
    @order_item = @order.order_items.find_or_initialize_by(product_id: params[:product_id])
    @order_item.quantity.nil? ? @order_item.quantity = params[:quantity].to_i : @order_item.quantity += params[:quantity].to_i

    return render json: { error: 'not save' }, status: :bad_request unless @order_item.save

    render json: {}, status: :ok
  end
end
