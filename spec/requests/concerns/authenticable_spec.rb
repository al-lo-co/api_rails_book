require 'rails_helper'

RSpec.describe "Concers::Authenticable" do
  let(:password) { 'password1' }
  let(:user) { User.create(email: 'example@das.com', password: password) }
  let(:authentication) { MockController.new }
  
  it "Should get the user from authorization token" do
    authentication.request.headers["Authorization"] = JsonWebToken.encode(user_id: user.id)
    
    expect(authentication.current_user.id).to be(user.id)
  end

  it "should not get user from empty Authorization token" do
    authentication.request.headers["Authorization"] = nil

    expect(authentication.current_user).to be_nil
  end
end

class MockController
  include Authenticable
  attr_accessor :request

  def initialize
    mock_request = Struct.new(:headers)
    self.request = mock_request.new({})
  end
end
