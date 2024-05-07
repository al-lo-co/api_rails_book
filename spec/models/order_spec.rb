require 'rails_helper'

RSpec.describe Order, type: :model do
  context "validity" do
    let(:product1) { create(:product) }
    let(:product2) { create(:product) }
    let(:order) { create(:order, product_ids: [product1.id, product2.id]) }

    it "Valid order" do
      expect(order).to be_valid
    end

    it "Invalid order" do
      order.user = nil

      expect(order).to_not be_valid
    end

    it "should show the total" do
      expect(order.total).to eq(product1.price + product2.price)
    end
  end
end
