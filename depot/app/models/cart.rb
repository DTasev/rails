class Cart < ApplicationRecord
  # dependent destroy means that when we remove a cart, Rails will destroy
  # any line_items associated with that cart
  has_many :line_items, dependent: :destroy
end
