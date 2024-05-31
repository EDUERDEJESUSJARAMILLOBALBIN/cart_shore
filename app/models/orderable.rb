class Orderable
  include Mongoid::Document
  include Mongoid::Timestamps

  field :quantity, type: Integer
  field :total_price, type: Integer
  field :order_created, type: Boolean, default: false
  field :code_order, type: String, default: '0000'
  field :session_id, type: String

  belongs_to :product
  belongs_to :cart

  index({ cart_id: 1, product_id: 1 }, { unique: true })

  def total
    product.price * quantity
  end
end
