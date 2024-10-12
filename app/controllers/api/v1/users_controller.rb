# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def index
        @users = User.all
      end

      def create
        @user = User.new(user_params)

        if @user.save
          render json: @user, status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def show
        @user = User.find_by(id: params[:id])

        if @user
          render 'api/v1/users/show', status: :ok
        else
          render json: { status: :not_found,
                         code: 404,
                         message: "The user with this id doesn't exist so please check again." }, status: :not_found
        end
      end

      def update
        @user = User.find_by(id: params[:id])

        if @user
          if @user.update(user_params)
            render json: @user, status: :ok
          else
            render json: { status: :unprocessable_entity,
                           code: 422,
                           errors: @user.errors.full_messages,
                           message: 'The error occurs when we try to update the user.' }, status: :unprocessable_entity
          end
        else
          render json: { status: :not_found,
                         code: 404,
                         message: "The user with this id doesn't exist so please check again." }, status: :not_found
        end
      end

      private

      def user_params
        params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :role)
      end
    end
  end
end
