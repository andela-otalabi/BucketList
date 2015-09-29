class Api::V1::BucketlistsController < ApplicationController
  before_action :set_bucketlist, only: [:show, :update, :destroy]
  before_action :authenticate, only: [:create, :show, :update, :destroy]

  # GET /api/v1/bucketlists
  # GET /api/v1/bucketlists.json
  def index
    @bucketlists = Bucketlist.all
    render json: @bucketlists
  end

  # GET /api/v1/bucketlists/1
  # GET /api/v1/bucketlists/1.json
  def show
    render json: @bucketlist
  end

  # POST /api/v1/bucketlists
  # POST /api/v1/bucketlists.json
  def create
    @bucketlist = Bucketlist.new(bucketlist_params)

    if @bucketlist.save
      render json: @bucketlist, status: :created, location: api_v1_bucketlist_path(@bucketlist)
    else
      render json: @bucketlist.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/bucketlists/1
  # PATCH/PUT /api/v1/bucketlists/1.json
  def update
    @bucketlist = Bucketlist.find(params[:id])

    if @bucketlist.update(bucketlist_params)
      head :no_content
    else
      render json: @bucketlist.errors, status: :unprocessable_entity
    end
  end
  
  # DELETE /api/v1/bucketlists/1
  # DELETE /api/v1/bucketlists/1.json
  def destroy
    @bucketlist.destroy
    head :no_content
  end

  private

    def set_bucketlist
      @bucketlist = Bucketlist.find(params[:id])
    end

    def bucketlist_params
      params.permit(:name, :user_id)
    end

end