require 'rails_helper'

RSpec.describe "Api::V1::Products", type: :request do
  describe "GET /show" do
    let!(:product) { create(:product) }
    let(:params) { { id: product.id } }
    let(:headers) { { Authorization: JsonWebToken.encode(user_id: user.id) } }
    it "returns http success" do
      get api_v1_product_path(id: product.id), as: :json

      expect(response.parsed_body["title"]).to eq(product.title)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    let(:products) { create_list(:product, 5) }

    it "returns http success" do
      get api_v1_products_path, as: :json

      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    let(:user) { create(:user) }
    let(:headers) { { Authorization: JsonWebToken.encode(user_id: user.id) } }
    let(:params) { { product: { title: Faker::Name, price: 0.1, published: true } } }
    it "returns http status created" do
      post api_v1_products_path, params: , headers: , as: :json

      expect(response).to have_http_status(:created)
    end
  end
end
