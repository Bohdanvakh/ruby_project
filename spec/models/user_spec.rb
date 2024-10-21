# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  context 'Should validate' do
    it 'with email, first_name, last_name, role' do
      expect(user).to be_valid
    end

    it 'when email is not present' do
      user.email = nil
      expect(user).to_not be_valid
    end

    it 'when first_name is not present' do
      user.first_name = nil
      expect(user).to_not be_valid
    end

    it 'when last_name is not present' do
      user.last_name = nil
      expect(user).to_not be_valid
    end

    it 'when role is not present' do
      user.role = nil
      expect(user).to_not be_valid
    end
  end
end
