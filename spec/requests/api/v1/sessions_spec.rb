require 'rails_helper'

RSpec.describe "User Log in endpoint" do 
  describe "POST /api/v1/sessions" do
    it "returns a successfil response with user information if user authenticated" do
      user = User.create(name: "Odell", email: "goodboy@ruffruff.com", password: "password")
      credentials = {
        "email": "goodboy@ruffruff.com", 
        "password": "password"
      }
      post "/api/v1/sessions", params: credentials, as: :json

      expect(response).to be_successful
      expect(response.status).to eq(200)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body[:data]).to be_a(Hash)
      expect(response_body[:data]).to have_key(:id)
      expect(response_body[:data][:id]).to be_a(String)
      expect(response_body[:data]).to have_key(:type)
      expect(response_body[:data][:type]).to eq("user")

      attributes = response_body[:data][:attributes]

      expect(attributes).to have_key(:name)
      expect(attributes[:name]).to be_a(String)
      expect(attributes[:name]).to eq(user.name)
      expect(attributes).to have_key(:email)
      expect(attributes[:email]).to be_a(String)
      expect(attributes[:email]).to eq(user.email)
      expect(attributes).to have_key(:api_key)
      expect(attributes[:api_key]).to be_a(String)
    end
  end

  describe "sad paths" do
    it "returns an error if the user email is not found without saying it's due to the email" do
      user = User.create(name: "Odell", email: "goodboy@ruffruff.com", password: "password")
      credentials = {
        "email": "wrong@ruffruff.com", 
        "password": "password"
      }
      post "/api/v1/sessions", params: credentials, as: :json


      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body[:error]).to eq("Invalid email or password")
    end

    it "returns an error if the user password is incorrect without saying it's due to the password" do
      user = User.create(name: "Odell", email: "goodboy@ruffruff.com", password: "password")
      credentials = {
        "email": "goodboy@ruffruff.com", 
        "password": "wrongpassword"
      }
      post "/api/v1/sessions", params: credentials, as: :json


      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body[:error]).to eq("Invalid email or password")
    end
  end
end