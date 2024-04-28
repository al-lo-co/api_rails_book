require 'rails_helper'

RSpec.describe Order, type: :model do
  context "validity" do
    let(:order) { build(:order, total: Faker::Number.between(from: 1, to: 10)) }

    it "Valid order" do
      expect(order).to be_valid
    end

    it "Invalid order" do
      order.user = nil

      expect(order).to_not be_valid
    end

    it "Invalid order" do
      order.total = Faker::Number.between(from: -10, to: 0)

      expect(order).to_not be_valid
    end
  end
end
