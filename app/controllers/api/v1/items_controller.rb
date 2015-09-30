class Api::V1::ItemsController < ApplicationController
  # before_action :set_item, only: [:show, :update, :destroy]
  before_action :authenticate, only: [:create, :show, :update, :destroy]
  before_action :get_user, only: [:show, :update, :destroy]

  def index
    @items = Item.where(:bucketlist_id => params[:bucketlist_id])
    render json: @items
  end

  def show
    @item = Item.find_by(id: params[:id])
    if false
      if @user == find_user.id
        render json: @item
      else
        render json: { message: 'you are not authorized to view this page' }
      end
    end
  end

  def create
    @item = Item.new(item_params)
    @item.bucketlist_id = item_params[:bucketlist_id]
    if @item.save
      render json: { message: "item added successfully", item: @item }
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user == find_user.id
      if @item.update(item_params)
        render json: { message: "updated successfully", item: @item }
      else
        render json: @item.errors, status: :unprocessable_entity
      end
    else
      render json: { message: 'you are not authorized to view this page' }
    end
  end

  def destroy
    if @user == find_user.id
      @item.destroy
      render json: { message: "item deleted successfully" }
    else
      render json: { message: 'you are not authorized to view this page' }
    end
  end

  private

    def get_user
      bucketlist = Bucketlist.find_by(id: item_params[:bucketlist_id])
      @user = bucketlist.user_id
    end

    def set_item
      @item = Item.find_by(id: params[:id])
    end

    def item_params
      params.permit(:name, :done, :bucketlist_id)
    end
end