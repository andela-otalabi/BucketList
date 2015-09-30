class Api::V1::BucketlistsController < ApplicationController
  before_action :set_bucketlist, only: [:show, :update, :destroy]
  before_action :authenticate, only: [:create, :show, :update, :destroy]
  before_action :get_user, only: [:show, :update, :destroy]

  def index
    @bucketlists = Bucketlist.all
    render json: @bucketlists, each_serializer: AllbucketlistsSerializer
  end

  def show
    if @user == find_user.id
      render json: @bucketlist
    else
      render json: { message: 'you are not authorized to view this page' }
    end
  end

  def create
    @bucketlist = Bucketlist.new(bucketlist_params)
    @bucketlist.user_id = find_user.id

    if @bucketlist.save
      render json: @bucketlist, status: :created, location: api_v1_bucketlist_path(@bucketlist)
    else
      render json: @bucketlist.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user == find_user.id
      @bucketlist = Bucketlist.find(params[:id])

      if @bucketlist.update(bucketlist_params)
        render json: { message: "bucketlist updated!" }
      else
        render json: @bucketlist.errors, status: :unprocessable_entity
      end
    else
      render json: { message: 'you are not authorized to view this page' }
    end
  end
  
  def destroy
    if @user == find_user.id
      @bucketlist.destroy
      render json: { message: "bucketlist deleted" }
    else
      render json: { message: 'you are not authorized to view this page' }
    end
  end

  private
    def get_user
      @user = @bucketlist.user_id if @bucketlist
    end

    def set_bucketlist
      @bucketlist = Bucketlist.find_by(id: params[:id])
    end

    def bucketlist_params
      params.permit(:name, :user_id)
    end

end