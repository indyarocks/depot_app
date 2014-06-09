require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
    product = Product.new(
        title: "RAILS 4",
        description: "This is rails 4 book.",
        image_url: 'ck.jpg'
    )

    product.price = -1

    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(
        title: "Image Url Book",
        description: "Image Url Book Description",
        price: 1,
        image_url: image_url
    )
  end

  test "image url" do
    valid_type = %w(gif png jpg jpeg)
    invalid_type = %w(hi bye check)

    valid_type.each do |ext|
      product = new_product("check.#{ext}")
      assert product.valid?, "check.#{ext}"
    end

    invalid_type.each do |ext|
      product = new_product("check.#{ext}")
      assert product.invalid?, "check.#{ext}"
      assert_equal ["must be a URL for GIF, PNG, JPG or JPEG image."], product.errors[:image_url]
    end
  end

  test "product is not valid without a unique title" do
    product = Product.new(
        title: products(:ruby).title,
        description: "xyz",
        price: 11,
        image_url: 'ruby.jpg'
    )

    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end



end
