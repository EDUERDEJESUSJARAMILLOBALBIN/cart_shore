class OrderablesController < ApplicationController
  def index
    @orderables = Orderable.where(order_created: true, session_id: session.id.to_s)
    @orderables_grouped_by_order = @orderables.group_by(&:code_order)
    @order_totals = @orderables_grouped_by_order.transform_values do |orderables|
      orderables.sum(&:total)
    end
    @total_all_orders = @order_totals.values.sum
  end

  def create_order
    @cart = Cart.find(session[:cart_id])
    order_code = generate_order_code
    @cart.orderables.where(order_created: false).each do |orderable|
      orderable.update(order_created: true, code_order: order_code, session_id: session.id.to_s)
    end
    redirect_to orderables_path, notice: 'The order has been saved successfully.'
  end

  def delete_order
    orderables = Orderable.where(code_order: params[:order_code], session_id: session.id.to_s)
    if orderables.destroy_all
      redirect_to orderables_path, notice: 'The order has been deleted successfully.'
    else
      redirect_to orderables_path, alert: 'Error deleting the order.'
    end
  end

  private

  def generate_order_code
    letters = ('A'..'Z').to_a.sample(3).join
    numbers = rand(100..999).to_s
    "#{letters}#{numbers}"
  end

  def calculate_order_totals(orderables_grouped)
    order_totals = {}
    orderables_grouped.each do |order_code, orderables|
      total_price = orderables.sum(&:total)
      order_totals[order_code] = total_price
    end
    order_totals
  end
end
