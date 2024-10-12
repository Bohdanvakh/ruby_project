# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: User do
    email { 'text@example.com' }
    first_name { 'John' }
    last_name { 'Doe' }
    role { 'Ruby Developer' }
    password { '!1234567890User' }
    password_confirmation { '!1234567890User' }
  end
end
