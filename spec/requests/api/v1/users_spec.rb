require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe "GET /show" do
    let!(:user) { User.create(email: "email@asd.co", password: "asdasda") }
    
    it "Show the user" do
      get api_v1_user_path(id: user.id), as: :json

      expect(response.parsed_body["email"]).to eq(user.email)
      expect(response).to have_http_status(:success)
    end
  end

  describe "post api_v1_users_path" do
    let(:user) { User.new(email: "email@asd.co", password: "asdasda") }

    it "Should create the user" do
      post api_v1_users_path, params: { user: { email: user.email, password: user.password } }, as: :json

      expect(response).to have_http_status(:created)
    end

    it "Should not create the user" do
      user.save!

      post api_v1_users_path, params: { user: { email: user.email, password: user.password } }, as: :json

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "patch api_v1_users_path" do
    let(:user) { User.create(email: "email@asd.co", password: "asdasda") }
    let(:headers) { { Authorization: JsonWebToken.encode(user_id: user.id) } }

    it "Should update the user" do
      patch api_v1_user_path(id: user.id), params: { user: { email: user.email, password: user.password } }, headers: , as: :json

      expect(response).to have_http_status(:success)
    end

    it "Should not update the user" do
      patch api_v1_user_path(id: user.id), params: { user: { email: "bad email", password: user.password } }, headers: , as: :json

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "Should forbit update the user" do
      patch api_v1_user_path(id: user.id), params: { user: { email: user.email, password: user.password } }, as: :json

      expect(response).to have_http_status(:forbidden)
    end
  end

  describe "delete api_v1_user_path" do
    let(:user) { User.create(email: "email@asd.co", password: "asdasda") }
    let(:headers) { { Authorization: JsonWebToken.encode(user_id: user.id) } }

    it "should delete the user" do
      delete api_v1_user_path(id: user.id), headers: , as: :json

      expect(response).to have_http_status(204)
    end

    xit "should not delete the user" do
      delete api_v1_user_path(id: 1), headers: , as: :json

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "should forbid delete the user" do
      delete api_v1_user_path(id: user.id), as: :json

      expect(response).to have_http_status(:forbidden)
    end
  end
end
