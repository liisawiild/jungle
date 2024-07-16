require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do 
    it "saves a product that has a name, price, quantity, and category" do 
      @category = Category.new
      @product = Product.new(name: "Test" , price_cents: "5", quantity: "1", category: @category)
      
      @product.save!
      expect(@product.id).to be_present
    end

    it "will throw an error if a product doesn't have a name" do 
      @category = Category.new
      @product = Product.new(name: nil , price_cents: "5", quantity: "1", category: @category)
      
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
      
    end

    it "will throw an error if a product doesn't have a price" do 
      @category = Category.new
      @product = Product.new(name: "Test" , price_cents: nil, quantity: "1", category: @category)
      
      @product.save
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it "will throw an error if a product doesn't have a quantity" do 
      @category = Category.new
      @product = Product.new(name: "Test" , price_cents: "5", quantity: nil, category: @category)
      
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "will throw an error if a product doesn't have a category" do 
      @category = Category.new
      @product = Product.new(name: "Test" , price_cents: "5", quantity: "1", category: nil)
      
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
