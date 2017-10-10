class AddProductPriceToLineItems < ActiveRecord::Migration[5.1]
  def change
    add_column :line_items, :product_price, :decimal
  end
end
