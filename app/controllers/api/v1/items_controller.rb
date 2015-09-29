module Api
  module V1
    class ItemsController < ApplicationController
      before_action :setitem, only: [:show, :update, :destroy]

      # GET /api/v1/items
      # GET /api/v1/items.json
      def index
        @items = Item.all

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

        if @item.save
          render json: @item, status: :created, location: api_v1_item_path(@item)
        else
          render json: @item.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/items/1
      # PATCH/PUT /api/v1/items/1.json
      def update
        @item = Item.find(params[:id])

        if @item.update(item_params)
          head :no_content
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
  end
end