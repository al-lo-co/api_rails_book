require 'rails_helper'

RSpec.describe Order, type: :model do
  context "validity" do
    let(:product1) { create(:product) }
    let(:product2) { create(:product) }
    let(:order) { create(:order, product_ids: [product1.id, product2.id]) }
    let(:order2) { build(:order) }
    let(:product_ids_and_quantities) do
      [
        { product_id: product1.id, quantity: 3 },
        { product_id: product2.id, quantity: 2 }
      ]
    end

    it "Valid order" do
      expect(order).to be_valid
    end

    it "Invalid order" do
      order.user = nil

      expect(order).to_not be_valid
    end

    it "should show the total" do
      order.placements = [ 
        Placement.new(product_id: product1.id, quantity: 2),
        Placement.new(product_id: product2.id, quantity: 2),
       ]
      order.set_total!

      expect(order.total).to eq((product1.price * 2) + (product2.price * 2))
    end

    it "should build placements" do
      order2.build_placements_with_product_ids_and_quantities(product_ids_and_quantities)

      expect(order.placements.size).to eq(2) 
    end

    it "order should not claim too much product than available" do
      order.placements << Placement.new(product_id: product1.id, quantity: (1 + product1.quantity))

      expect(order).to_not be_valid
    end
  end
end
