class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end

  def create
    @order = current_user.orders.create(total_price: current_cart.total_price)
    current_cart.cart_items.each do |item|
      @order.order_items.create(product: item.product, quantity: item.quantity)
    end
    current_cart.destroy
    redirect_to order_path(@order)
  end
end