class ApplicationController < ActionController::Base
  before_action :set_render_cart
  before_action :initialize_cart

  def set_render_cart
    @render_cart = true
  end

  def initialize_cart
    @cart = session[:cart_id].present? ? find_cart : create_cart
  end

  private

  def find_cart
    Cart.find_by(id: BSON::ObjectId.from_string(session[:cart_id]))
  rescue BSON::ObjectId::Invalid
    nil
  end

  def create_cart
    cart = Cart.create
    session[:cart_id] = cart.id.to_s
    cart
  end
end
