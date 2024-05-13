require 'rails_helper'

RSpec.describe Placement, type: :model do
  context "decrease the product quantity by the placement quantity" do
    let(:placement) { create(:placement) }

    xit "should decrease the product quantity" do
      expect(placement.product.quantity).to eq(placement.quantity)
    end
  end
end
