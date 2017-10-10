require 'test_helper'

class CartTest < ActiveSupport::TestCase
  test "adding product copies price" do
    product = products(:ruby)
    cart = carts(:one)
    line_item = cart.add_product(product)
    product.price = 153
    product.save

    assert line_item.product_price != product.price
  end
end
