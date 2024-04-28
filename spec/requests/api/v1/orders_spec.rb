require 'rails_helper'

RSpec.describe "Api::V1::Orders", type: :request do
  describe "GET /index" do
    let(:user) { create(:user) }
    let(:order) { create(:order, user_id: user.id) }
    let(:headers) { { Authorization: JsonWebToken.encode(user_id: order.user.id) } }

    it "should forbid orders for unlogged" do
      get api_v1_orders_path, as: :json

      expect(response).to have_http_status(:forbidden)
    end

    it "should show orders" do
      get api_v1_orders_path, as: :json, headers: , as: :json

      expect(response).to have_http_status(:success)
      expect(response.parsed_body.size).to eq(order.user.orders.size)
    end
  end
end
