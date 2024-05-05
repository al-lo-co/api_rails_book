require "rails_helper"

RSpec.describe OrderMailer, type: :mailer do
  describe "send_confirmation" do
    let(:order) {create(:order)}
    let(:mail) { OrderMailer.send_confirmation(order) }

    it "renders the headers" do
      expect(mail.subject).to eq("Send confirmation")
      expect(mail.to).to eq([order.user.email])
      expect(mail.from).to eq(['no-reply@marketplace.com'])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
