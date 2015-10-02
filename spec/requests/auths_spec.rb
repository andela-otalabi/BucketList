require 'rails_helper'

RSpec.describe "Auths", type: :request do
  describe "api/v1/auth" do
    before :each do
      @user = User.create(name: "seyi", email: "seyi@andela.com", password: "123456")
    end

    it "should log in a user and return a token" do
      post '/api/v1/auth/login', { email: @user.email, password: @user.password }

      res = JSON.parse(response.body)
      expect(res).to include("token")
      get '/api/v1/auth/logout', {"token" => "#{@user.token}"}

      message = JSON.parse(response.body)["message"]
      expect(message).to eq("You have logged out successfully")

    end

    it "should log out a logged in user" do
    end
  end
end