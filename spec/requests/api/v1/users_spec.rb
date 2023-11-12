require 'rails_helper'

RSpec.describe "User Registration endpoint" do
  describe "POST /api/v1/users" do
    it "can create a user in the database with encrypted password and generated api_key" do
      user = {
        "name": "Odell",
        "email": "goodboy@ruffruff.com",
        "password": "treats4lyf",
        "password_confirmation": "treats4lyf"
      }
      post "/api/v1/users", params: user, as: :json

      expect(response).to be_successful
      expect(response.status).to eq(201)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body[:data]).to be_a(Hash)
      expect(response_body[:data]).to have_key(:id)
      expect(response_body[:data][:id]).to be_a(String)
      expect(response_body[:data]).to have_key(:type) 
      expect(response_body[:data][:type]).to eq("user")
      expect(response_body[:data]).to have_key(:attributes)
      expect(response_body[:data][:attributes]).to be_a(Hash)

      attributes = response_body[:data][:attributes]
      
      expect(attributes).to have_key(:name)
      expect(attributes[:name]).to be_a(String)
      expect(attributes[:name]).to eq(user[:name])
      expect(attributes).to have_key(:email)
      expect(attributes[:email]).to be_a(String)
      expect(attributes[:email]).to eq(user[:email])
      expect(attributes).to have_key(:api_key)
      expect(attributes[:api_key]).to be_a(String)
      expect(attributes[:api_key].length).to eq(40)
    end
  end

  describe "sad path" do
    it "returns an error if the passwords don't match" do
      user = {
        "name": "Odell",
        "email": "goodboy@ruffruff.com",
        "password": "treats4lyf",
        "password_confirmation": "wrongconfirmation"
      }
      post "/api/v1/users", params: user, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      response_body = JSON.parse(response.body, symbolize_names: true)
      expect(response_body[:error]).to eq("Password confirmation doesn't match Password")
    end

    it "returns an error if the user email already taken" do 
      user2 = User.create(name: "Person", email: "goodboy@ruffruff.com", password: "password")
      user = {
        "name": "Odell",
        "email": "goodboy@ruffruff.com",
        "password": "treats4lyf",
        "password_confirmation": "treats4lyf"
      }
      post "/api/v1/users", params: user, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body[:error]).to eq("Email has already been taken")
    end
  end
end