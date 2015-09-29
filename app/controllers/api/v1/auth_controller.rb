module Api
  module V1
    class AuthController < ApplicationController
      def login
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
          render json: user
        else
          render json: { errors: 'Invalid email/password combination' }
        end
      end

      def logout

      end
    end
  end
end