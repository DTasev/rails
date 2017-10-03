require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # loads the data into the products database before each test
  fixtures(:products)

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
    product = Product.new(title: "My book title", description: "zzz", image_url: "yyy.jpg")

    product.price = -1
    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(title: "My book title", description: "zzz", image_url: image_url, price: 1)
  end

  test "image url validation" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be invalid"
    end
    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end
  end

  def my_sexy_product_updater(full_product, *overwrite_fields)
    product = full_product.dup
    # update the fields of the product
    overwrite_fields.each do |attr|
      key, value = attr.first
      if product.has_key?(key) && !key.nil?
        product[key] = value
      end
      return product
    end
  end

  test "product is not valid without a unique title - i18n" do
    product = products :ruby
    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]
  end
end
