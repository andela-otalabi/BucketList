class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]
   before_action :authenticate, only: [:create, :show, :update, :destroy]

  # GET /api/v1/items
  # GET /api/v1/items.json
  def index
    @items = Item.where(:bucketlist_id => params[:bucketlist_id])

    render json: @items
  end

  # GET /api/v1/items/1
  # GET /api/v1/items/1.json
  def show
    render json: @item
  end

  # POST /api/v1/items
  # POST /api/v1/items.json
  def create
    @item = Item.new(item_params)
    @item.bucketlist_id = item_params[:bucketlist_id]
    if @item.save
      render json: @item, status: :created
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/items/1
  # PATCH/PUT /api/v1/items/1.json
  def update
    @item = Item.find(params[:id])

    if @item.update(item_params)
      render json: { message: "updated successfully", item: @item }
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/items/1
  # DELETE /api/v1/items/1.json
  def destroy
    @item.destroy

    head :no_content
  end

  private

    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.permit(:name, :done, :bucketlist_id)
    end
end