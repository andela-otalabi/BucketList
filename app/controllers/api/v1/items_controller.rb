class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]
  before_action :authenticate, only: [:create, :show, :update, :destroy]

  def index
    @items = Item.where(:bucketlist_id => params[:bucketlist_id])
    render json: @items
  end

  def show
    render json: @item
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
    @item = Item.find(params[:id])

    if @item.update(item_params)
      render json: { message: "updated successfully", item: @item }
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    render json: { message: "item deleted successfully" }
  end

  private

    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.permit(:name, :done, :bucketlist_id)
    end
end