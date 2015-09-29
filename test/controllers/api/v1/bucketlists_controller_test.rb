require 'test_helper'

class Api::V1::BucketlistsControllerTest < ActionController::TestCase
  setup do
    @api_v1_bucketlist = api_v1_bucketlists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_v1_bucketlists)
  end

  test "should create api_v1_bucketlist" do
    assert_difference('Api::V1::Bucketlist.count') do
      post :create, api_v1_bucketlist: {  }
    end

    assert_response 201
  end

  test "should show api_v1_bucketlist" do
    get :show, id: @api_v1_bucketlist
    assert_response :success
  end

  test "should update api_v1_bucketlist" do
    put :update, id: @api_v1_bucketlist, api_v1_bucketlist: {  }
    assert_response 204
  end

  test "should destroy api_v1_bucketlist" do
    assert_difference('Api::V1::Bucketlist.count', -1) do
      delete :destroy, id: @api_v1_bucketlist
    end

    assert_response 204
  end
end
