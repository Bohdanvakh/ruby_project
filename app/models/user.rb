# frozen_string_literal: true

class User < ApplicationRecord # rubocop:disable Style/Documentation
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true,
                         format: { with: /[a-zA-Z]/, message: 'can only contain letters' },
                         length: { minimum: 2, maximum: 60 }
  validates :last_name, presence: true,
                        format: { with: /[a-zA-Z]/, message: 'can only contain letters' },
                        length: { minimum: 2, maximum: 60 }
  validates :role, presence: true,
                   format: { with: /[a-zA-Z]/, message: 'can only contain letters' },
                   length: { minimum: 4, maximum: 90 }
end
