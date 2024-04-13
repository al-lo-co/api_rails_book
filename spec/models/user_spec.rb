require "rails_helper"

RSpec.describe User, type: :model do
  context "validity" do
    let(:user1) { User.create(email: "email@dasd.co", password: "123456") }
    let(:user2) { User.new(email: "email@dasd.co", password: "123456") }

    before do
      user1
    end

    it "Valid user" do
      expect(user1).to be_valid
    end

    it "Not valid user" do
      user = User.new(email: "emaildasd.co", password: "123456")
      expect(user).to_not be_valid
    end

    it "Not valid user, duplicated email" do
      expect(user2).to_not be_valid
    end
  end
end
