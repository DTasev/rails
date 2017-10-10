class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def total_price
    self[:product_price] * quantity
  end
end
