class Api::V1::AuthController < ApplicationController
  before_action :authenticate, only: [:logout]
  def login
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      render json: { token: user.token, message: "You have successfully logged in" }
    else
      render json: { errors: 'Invalid email/password combination' }
    end
  end

  def logout

  end
end