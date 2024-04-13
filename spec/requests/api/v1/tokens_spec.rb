require 'rails_helper'

RSpec.describe "Api::V1::Tokens", type: :request do
  describe "POST /create" do
    let(:password) { 'password1' }
    let(:user) { User.create(email: 'example@das.com', password: password) }
    it "Should get the token" do
      post api_v1_tokens_path, params: { user: { email: user.email, password: password } }, as: :json
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body).not_to be_nil
    end

    it "Should not get the token" do
      post api_v1_tokens_path, params: { user: { email: user.email, password: 'bad_password'} }, as: :json
      
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
