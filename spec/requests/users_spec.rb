# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do # rubocop:disable Metrics/BlockLength
  let!(:user) { create(:user) }

  describe 'GET /api/v1/users' do # index
    it 'returns a successful response' do
      get '/api/v1/users'

      json_response = JSON.parse(response.body)
      expected_attributes = {
        'id' => user.id,
        'email' => user.email,
        'first_name' => user.first_name,
        'last_name' => user.last_name,
        'role' => user.role
      }

      expect(response).to have_http_status(:success)
      expect(json_response[0].except('created_at', 'updated_at')).to eq(expected_attributes)
    end
  end

  describe 'POST /api/v1/users' do # create
    it 'returns a successful response' do
      post '/api/v1/users', params: { email: 'example@test.com',
                                      first_name: 'John',
                                      last_name: 'Doe',
                                      password: '1234567890',
                                      password_confirmation: '1234567890',
                                      role: 'UX designer' }

      json_response = JSON.parse(response.body)
      expected_attributes = {
        'email' => 'example@test.com',
        'first_name' => 'John',
        'last_name' => 'Doe',
        'role' => 'UX designer'
      }

      expect(response).to have_http_status(:success)
      expect(json_response.except('id', 'created_at', 'updated_at')).to eq(expected_attributes)
    end
  end

  describe 'GET /api/v1/users/:id' do # show
    it 'returns a successful response' do
      get "/api/v1/users/#{user.id}"

      json_response = JSON.parse(response.body)
      expected_attributes = {
        'id' => user.id,
        'email' => user.email,
        'first_name' => user.first_name,
        'last_name' => user.last_name,
        'role' => user.role
      }

      expect(response).to have_http_status(:success)
      expect(json_response.except('created_at', 'updated_at')).to eq(expected_attributes)
    end

    it 'returns 404 response' do
      get '/api/v1/users/1234567890' # there is no user with this ID

      json_response = JSON.parse(response.body)
      expected_attributes = {
        'status' => 'not_found',
        'code' => 404,
        'message' => "The user with this id doesn't exist so please check again."
      }

      expect(response).to have_http_status(:not_found)
      expect(json_response).to eq(expected_attributes)
    end
  end

  # update
  describe 'PATCH /api/v1/users/:id' do # rubocop:disable Metrics/BlockLength
    it 'returns a successful response' do
      expect(user.role).to eq('Ruby Developer')

      patch "/api/v1/users/#{user.id}", params: { role: 'UX designer' }

      json_response = JSON.parse(response.body)
      expected_attributes = {
        'id' => user.id,
        'email' => user.email,
        'first_name' => user.first_name,
        'last_name' => user.last_name,
        'role' => 'UX designer'
      }

      expect(response).to have_http_status(:success)
      expect(json_response.except('created_at', 'updated_at')).to eq(expected_attributes)
    end

    it 'returns 404 response' do
      patch "/api/v1/users/#{user.id}", params: { first_name: 'A' } # invalid role

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns 404 response' do
      patch '/api/v1/users/1234567890', params: { role: 'UX designer' } # there is no user with this ID

      json_response = JSON.parse(response.body)
      expected_attributes = {
        'status' => 'not_found',
        'code' => 404,
        'message' => "The user with this id doesn't exist so please check again."
      }

      expect(response).to have_http_status(:not_found)
      expect(json_response).to eq(expected_attributes)
    end
  end
end
