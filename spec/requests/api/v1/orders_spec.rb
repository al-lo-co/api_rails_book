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

  describe "GET /show" do
    let(:user) { create(:user) }
    let(:product) { create(:product, user_id: user.id) }
    let(:order) { create(:order, user_id: user.id, product_ids: [product.id]) }
    let(:headers) { { Authorization: JsonWebToken.encode(user_id: order.user_id) } }

    it "should forbid orders for unlogged" do
      get api_v1_orders_path(id: order.id), as: :json

      expect(response).to have_http_status(:forbidden)
    end

    it "should show orders" do
      get api_v1_order_path(id: order.id), as: :json, headers: , as: :json

      expect(response).to have_http_status(:success)
      expect(response.parsed_body["total"].to_f).to eq(order.total)
      expect(response.parsed_body["products"][0]["title"]).to eq(product.title)
    end
  end

  describe "POST /create" do
    let(:user) { create(:user) }
    let(:product) { create(:product, user_id: user.id) }
    let(:params) { { order: { product_ids: [product.id], total: 50} } }
    let(:headers) { { Authorization: JsonWebToken.encode(user_id: user.id) } }

    it "should forbid create order" do
      post api_v1_orders_path, params: , as: :json

      expect(response).to have_http_status(:forbidden)
    end

    it "should forbid create order" do
      post api_v1_orders_path, params: , headers: , as: :json

      expect(response.parsed_body["products"][0]["title"]).to eq(product.title)
      expect(response).to have_http_status(:created)
    end
  end
end
