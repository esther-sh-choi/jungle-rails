# Run: rails g rspec:model product
# to create this file

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Validations" do
    before do
      @category = Category.create(name: 'Tree')
    #   @product = Product.new(
    #     name: "Elder Tree",
    #     price_cents: 100000,
    #     quantity: 10,
    #     category: @category,
    #     id: 1,
    #     description: "This is a magical tree.",
    #     image: "https://static.wikia.nocookie.net/snitchseekerrpg/images/d/d5/13_elder.jpg/revision/latest?cb=20110921173335",
    #     created_at: DateTime.now,
    #     updated_at: DateTime.now
    #   )
    end

    it 'should save successfully with all four columns' do
      @product = Product.new(name: "Elder Tree",
          price_cents: 100000,
          quantity: 10,
          category: @category)
      expect(@product).to be_valid
    end

    it "product should not save when name is nil" do
      @product = Product.new(name: nil)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "product should not save when price is nil" do
      @product = Product.new(price_cents: nil)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it "product should not save when quantity is nil" do
      @product = Product.new(quantity: nil)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "product should not save when category is nil" do
      @product = Product.new(category: nil)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end
