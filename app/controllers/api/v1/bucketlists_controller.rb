class Api::V1::BucketlistsController < ApplicationController
  before_action :set_bucketlist, only: [:show, :update, :destroy]
  before_action :find_user, except: [:index]

  def index
    @bucketlists = Bucketlist.all
    render json: @bucketlists, each_serializer: AllbucketlistsSerializer
  end

  def show
    if @user && @user.logged_in
      render json: @bucketlist
    else
      render json: { message: 'you are not authorized to view this page' }
    end
  end

  def create
    if @user && @user.logged_in
      @bucketlist = Bucketlist.new(bucketlist_params)
      @bucketlist.user_id = @user.id

      if @bucketlist.save
        render json: @bucketlist, status: :created, message: "created"
      else
        render json: { status: error }
      end
    end
  end

  def update
    if @user && @user.logged_in
      @bucketlist = Bucketlist.find(params[:id])

      if @bucketlist.update(bucketlist_params)
        render json: { message: "bucketlist updated!" }
      else
        render json: @bucketlist.errors
      end
    else
      render json: { message: 'you are not authorized to view this page' }
    end
  end
  
  def destroy
    if @user && @user.logged_in
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