require 'rails_helper'

RSpec.describe "Api::V1::Products", type: :request do
  describe "GET /api/v1/product/:id" do
    let!(:product) { create(:product) }
    let(:params) { { id: product.id } }
    let(:headers) { { Authorization: JsonWebToken.encode(user_id: user.id) } }
    it "returns http success" do
      get api_v1_product_path(id: product.id), as: :json

      expect(response.parsed_body["title"]).to eq(product.title)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /api/v1/products" do
    let(:products) { create_list(:product, 5) }

    it "returns http success" do
      get api_v1_products_path, as: :json

      expect(response).to have_http_status(:success)
    end
  end

  describe "POST api/v1/products" do
    let(:user) { create(:user) }
    let(:headers) { { Authorization: JsonWebToken.encode(user_id: user.id) } }
    let(:params) { { product: { title: Faker::Name, price: 0.1, published: true } } }
    it "returns http status created" do
      post api_v1_products_path, params: , headers: , as: :json

      expect(response).to have_http_status(:created)
    end

    it "returns http status forbidden" do
      post api_v1_products_path, params: , as: :json

      expect(response).to have_http_status(:forbidden)
    end
  end

  describe "Patch api/v1/product" do
    let(:headers) { { Authorization: JsonWebToken.encode(user_id: user.id) } }
    let(:product) { create(:product) }
    let(:user) { product.user }
    let(:params) { { product: { title: Faker::Name } } }
    it "returns http status created" do
      patch api_v1_product_path(id: product.id), params: , headers: , as: :json

      expect(response).to have_http_status(:success)
    end

    it "returns http status forbidden" do
      patch api_v1_product_path(id: product.id), params: , as: :json

      expect(response).to have_http_status(:forbidden)
    end
  end
end
