require 'rails_helper'

RSpec.describe "Items", type: :request do
  describe "GET api/v1/bucketlists/:id/items" do
    before :each do
      @user = User.create(name: "seyi", email: "seyi@andela.com", password: "123456", logged_in: true)
      @bucketlist = Bucketlist.create(name: "mountain climbing", user_id: @user.id)
    end

    it "should list all items in a bucket list" do
      get "/api/v1/bucketlists/"+"#{@bucketlist.id}"+"/items", 
      {"Authorization" => "Token token=#{@user.token}"}
      expect(response).to have_http_status(200)
    end

    it "add an item to a bucketlist" do
     post "/api/v1/bucketlists/"+"#{@bucketlist.id}"+"/items", {name: "mount everest"},
     {"Authorization" => "Token token=#{@user.token}"}
      res = JSON.parse(response.body)
      expect(res).to include("item")
    end

  end
end