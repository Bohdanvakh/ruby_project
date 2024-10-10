require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { create(:user) }

  describe "GET /api/v1/users" do
    it "returns a successful response" do
      get "/api/v1/users"

      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(json_response[0]["email"]).to eq(user.email)
    end
  end

  describe "POST /api/v1/users" do
    it "returns a successful response" do
      post "/api/v1/users", params: { email: "example@test.com",
                                      first_name: "John",
                                      last_name: "Doe",
                                      password: "1234567890",
                                      password_confirmation: "1234567890",
                                      role: "UX designer" }

      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(json_response["email"]).to eq("example@test.com")
    end
  end
end
