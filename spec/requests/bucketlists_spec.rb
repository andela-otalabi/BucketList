require 'rails_helper'

RSpec.describe "Bucketlists", type: :request do
  describe "GET api/v1/bucketlists" do
    before :each do
      @user = User.create(name: "seyi", email: "seyi@andela.com", password: "123456", logged_in: true)
    end

    it "should not allow unauthorized users create bucketlist" do
     post '/api/v1/bucketlists', {name: "mountain climbing"}
      message = JSON.parse(response.body)["message"]
      expect(message).to eq("you are not authorized to view this page")
    end

    it "should allow authorized users create bucketlist" do
      post '/api/v1/bucketlists', {name: "mounta"}
      @request.env["HTTP_AUTHORIZATION"] = "Token token=#{@user.token}"
      message = JSON.parse(response.body)
      bucketlists = @user.bucketlists
      expect(message).to eq("mountain climbing2223")
    end

    it "should list all bucketlists" do
      get '/api/v1/bucketlists'
      expect(response).to have_http_status(200)
    end

  end
end
