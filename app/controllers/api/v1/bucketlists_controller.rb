class Api::V1::BucketlistsController < ApplicationController
  before_action :set_bucketlist, only: [:show, :update, :destroy]
  before_action :authenticate, only: [:create, :show, :update, :destroy]

  def index
    @bucketlists = Bucketlist.all
    render json: @bucketlists
  end

  def show
    render json: @bucketlist
  end

  def create
    @bucketlist = Bucketlist.new(bucketlist_params)

    if @bucketlist.save
      render json: @bucketlist, status: :created, location: api_v1_bucketlist_path(@bucketlist)
    else
      render json: @bucketlist.errors, status: :unprocessable_entity
    end
  end

  def update
    @bucketlist = Bucketlist.find(params[:id])

    if @bucketlist.update(bucketlist_params)
      render json: { message: "bucketlist updated!" }
    else
      render json: @bucketlist.errors, status: :unprocessable_entity
    end
  end
  
  def destroy
    @bucketlist.destroy
    render json: { message: "bucketlist deleted" }
  end

  private

    def set_bucketlist
      @bucketlist = Bucketlist.find(params[:id])
    end

    def bucketlist_params
      params.permit(:name, :user_id)
    end

end