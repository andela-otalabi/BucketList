class Api::V1::ItemsController < ApplicationController
  before_action :authenticate, only: [:create, :show, :update, :destroy]
  before_action :find_user
  before_action :set_item, only: [:show, :update, :destroy]

  def index
    @items = Item.where(:bucketlist_id => params[:bucketlist_id])
    render json: @items
  end

  def show
    if @user && @user.logged_in
      @item = @user.items.find_by(id: params[:id])
      if @item
        render json: @item
      end
    end
  end

  def create
    @item = Item.new(item_params)
    @item.bucketlist_id = item_params[:bucketlist_id]
    if @item.save
      render json: { message: "item added successfully", item: @item }
    else
      render json: @item.errors
    end
  end

  def update
    if @user && @user.logged_in
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
    if @user && @user.logged_in
      @item.destroy
      render json: { message: "item deleted successfully" }
    else
      render json: { message: 'you are not authorized to view this page' }
    end
  end

  private

    def set_item
      @item = @user.items.find_by(id: params[:id])    
    end

    def item_params
      params.permit(:name, :done, :bucketlist_id)
    end
end