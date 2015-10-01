class Api::V1::ErrorsController < ApplicationController

  def not_found 
    render json: {error: "page not found", status: 404}, status: 404 
  end

end