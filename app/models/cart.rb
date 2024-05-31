class Cart
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :orderables

  def total
    orderables.to_a.sum { |orderable| orderable.total }
  end

  def products
    orderables.map(&:product)
  end
end
