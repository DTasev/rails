class Cart < ApplicationRecord
  # dependent destroy means that when we remove a cart, Rails will destroy
  # any line_items associated with that cart
  has_many :line_items, dependent: :destroy

  # Add a product to the cart.
  # If the product exists the quantity will be increased
  # If the product does not exist, a new line item will be created
  # @param product [Product] the product being added to the cart
  def add_product(product)
    current_item = line_items.find_by(product_id: product.id)

    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product.id, quantity: 1, product_price: product.price)
    end

    current_item
  end

  def total_price
    # reduce the price of all the line items
    line_items.to_a.sum { |item| item.total_price }
  end
end
