class CartController < ApplicationController
  before_action :initialize_cart

  def show
    @cart_items = @cart.orderables.where(order_created: false)
  end

  def add
    @product = Product.find_by(id: params[:id])
    return unless @product

    quantity = params[:quantity].to_i
    CartAdderService.new(cart: @cart, product: @product, quantity: quantity).add_to_cart

    redirect_to products_path
  end

  private

  def initialize_cart
    @cart ||= Cart.find_or_create_by(id: session[:cart_id]) do |cart|
      session[:cart_id] = cart.id
    end
  end
end
