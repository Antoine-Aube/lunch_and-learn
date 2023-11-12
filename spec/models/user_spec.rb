require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
  end

  describe "instance methods" do 
    it "generate_api_key" do
      user = User.new(name: "Bob", email: "bob@email.com", password: "password", password_confirmation:"password")
      user.generate_api_key

      expect(user.api_key).to be_a(String)
      expect(user.api_key.length).to eq(40)
    end 
  end
end