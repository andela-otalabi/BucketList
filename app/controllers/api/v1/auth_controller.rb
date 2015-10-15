class Api::V1::AuthController < ApplicationController
  before_action :find_user, only: [:logout]

  def login
    if params[:email] && params[:password] == nil
      res = JSON.parse(request.body.read)
      user = User.find_by_email(res['email'].downcase)
      password = res['password']
    else
      user = User.find_by_email(params[:email].downcase)
      password = params[:password]
    end
    
    if user && user.authenticate(password)
      user.logged_in = true
      user.save
      render json: { token: user.token, message: "You have successfully logged in" }
    else
      render json: { errors: 'Invalid email/password combination', p: params }
    end
  end

  def logout
    if @user
      @user.logged_in = false
       @user.generate_auth_token
      if @user.save
        render json: { message: "You have logged out successfully" }
      else
        render json: { errors: "Error logging out"}
      end
    end
  end

end