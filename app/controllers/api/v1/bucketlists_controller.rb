class Api::V1::BucketlistsController < ApplicationController
  before_action :set_bucketlist, only: [:show, :update, :destroy]
  before_action :find_user
  def index
    @bucketlists = Bucketlist.all
    render json: @bucketlists, each_serializer: AllbucketlistsSerializer
  end

  def show
    if @user
      render json: @bucketlist
    else
      render json: { message: 'you are not authorized to view this page' }
    end
  end

  def create
    if @user
      @bucketlist = Bucketlist.new(bucketlist_params)
      @bucketlist.user_id = @user.id

      if @bucketlist.save
        render json: @bucketlist, status: :created, location: api_v1_bucketlist_path(@bucketlist)
      else
        render json: @bucketlist.errors, status: :unprocessable_entity
      end
    end
  end

  def update
    if @user
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
    if @user
      @bucketlist.destroy
      render json: { message: "bucketlist deleted" }
    else
      render json: { message: 'you are not authorized to view this page' }
    end
  end

  private

    def set_bucketlist
      @bucketlist = Bucketlist.find_by(id: params[:id])
    end

    def bucketlist_params
      params.permit(:name, :user_id)
    end

end