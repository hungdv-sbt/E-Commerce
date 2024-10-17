class CartItemsController < ApplicationController
  def create
    @cart = current_user.cart || Cart.create(user: current_user)
    @cart_item = @cart.cart_items.find_or_initialize_by(product_id: params[:product_id])
    @cart_item.quantity += params[:quantity].to_i
    @cart_item.save
    redirect_to cart_path(@cart)
  end
end