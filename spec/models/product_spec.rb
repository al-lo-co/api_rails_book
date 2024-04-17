require 'rails_helper'

RSpec.describe Product, type: :model do
  context "validity" do
    let(:user) { User.create(email: "email@asd.co", password: "asdasda") }
    let(:product1) { Product.create(title: "email@dasd.co", price: 123456, published: true, user: user) }
    let(:product2) { Product.new(title: "email@dasd.co", price: -123456, published: false, user: user) }

    before do
      product1
    end

    it "Valid user" do
      expect(product1).to be_valid
    end

    it "Not valid user" do
      expect(product2).to_not be_valid
    end
  end
end
