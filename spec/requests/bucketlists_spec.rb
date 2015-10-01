require 'rails_helper'

RSpec.describe "Bucketlists", type: :request do
  describe "api/v1/bucketlists" do
    before :each do
      @user = User.create(name: "seyi", email: "seyi@andela.com", password: "123456", logged_in: true)
    end

    it "should list all bucketlists" do
      get '/api/v1/bucketlists'
      expect(response).to have_http_status(200)
    end
    
    it "should not allow unauthorized users create bucketlist" do
     post '/api/v1/bucketlists', {name: "mountain climbing"}
      message = JSON.parse(response.body)["message"]
      expect(message).to eq("you are not authorized to view this page")
    end

    it "should allow an authorized user create bucketlist" do
      post '/api/v1/bucketlists', { name: "mountain climbing"},
      {"Authorization" => "Token token=#{@user.token}"}
      message = JSON.parse(response.body)["bucketlist"]["name"]
      bucketlists = @user.bucketlists
      expect(bucketlists.count).to eq(1)
      expect(message).to eq("mountain climbing")
    end

    it "should allow an authorized user update a bucketlist" do
      post '/api/v1/bucketlists', { name: "mountain climbing"},
      {"Authorization" => "Token token=#{@user.token}"}

      put '/api/v1/bucketlists/1', { name: "mountains to climb"},
      {"Authorization" => "Token token=#{@user.token}"}
      message = JSON.parse(response.body)["bucketlist"]["name"]
      expect(message).to eq("mountains to climb")
    end

    it "should allow an authorized user delete a bucketlist" do
      delete '/api/v1/bucketlists/1',
      {"Authorization" => "Token token=#{@user.token}"}
      bucketlists = @user.bucketlists
      expect(bucketlists.count).to eq(0)
    end

    it "should not allow users view other users bucketlists" do
      post '/api/v1/bucketlists', { name: "mountain climbing"},
      {"Authorization" => "Token token=#{@user.token}"}

      get '/api/v1/bucketlists/9'
      message = JSON.parse(response.body)["message"]
      expect(message).to eq("you are not authorized to view this page")
    end

  end
end