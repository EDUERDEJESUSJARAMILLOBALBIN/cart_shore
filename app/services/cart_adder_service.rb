class CartAdderService
  def initialize(cart:, product:, quantity:)
    @cart = cart
    @product = product
    @quantity = quantity
  end

  def add_to_cart
    current_orderable = find_orderable_by_product(@product.id)

    if current_orderable
      update_or_destroy_orderable(current_orderable)
    elsif @quantity > 0
      @cart.orderables.create(product: @product, quantity: @quantity)
    end
  end

  private

  def find_orderable_by_product(product_id)
    @cart.orderables.find_by(product_id: BSON::ObjectId.from_string(product_id.to_s), order_created: false)
  rescue Mongoid::Errors::DocumentNotFound, BSON::ObjectId::Invalid
    nil
  end

  def update_or_destroy_orderable(orderable)
    if @quantity > 0
      orderable.update(quantity: orderable.quantity + @quantity)
    else
      orderable.destroy
    end
  end
end
