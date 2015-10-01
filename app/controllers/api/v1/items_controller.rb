class Api::V1::ItemsController < ApplicationController
  before_action :authenticate, only: [:create, :show, :update, :destroy]
  before_action :find_user
  before_action :set_item, only: [:show, :update, :destroy]
  before_action :get_bucketlist, only: [:index, :create]

  def index 
    if @user.bucketlists.include? @bucketlist
      @items = Item.where(:bucketlist_id => params[:bucketlist_id])
      render json: @items
    else
      render json: { message: "you can not view items that do not belong to you"}
    end
  end

  def show
    if @user.items.include? @item
      if @item
        render json: @item
      end
    else
      render json: { message: 'you are not authorized to view this page' }
    end
  end

  def create
    if @user.bucketlists.include? @bucketlist
      @item = Item.new(item_params)
      @item.bucketlist_id = item_params[:bucketlist_id]
      if @item.save
        render json: { message: "item added successfully", item: @item }
      end
    else
      render json: { message: "you can not create an item for non existing bucketlists" }
    end
  end

  def update
    if @user.items.include? @item
      if @item.update(item_params)
        render json: { message: "updated successfully", item: @item }
      else
        render json: @item.errors
      end
    else
      render json: { message: 'you are not authorized to view this page' }
    end
  end

  def destroy
    if @user.items.include? @item
      @item.destroy
      render json: { message: "item deleted successfully" }
    else
      render json: { message: 'you are not authorized to view this page' }
    end
  end

  private
    def get_bucketlist
      @bucketlist = Bucketlist.find_by(id: params[:bucketlist_id]) 
    end

    def set_item
      @item = @user.items.find_by(id: params[:id]) 
    end

    def item_params
      params.permit(:name, :done, :bucketlist_id)
    end
end