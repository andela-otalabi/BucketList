class Api::V1::UsersController < ApplicationController
  before_action :find_user, except: [:create]
  before_action :authenticate, only: [:show, :update, :destroy]

  def index
    # @users = User.all
    # render json: @users, each_serializer: AllusersSerializer
  end

  def show
    if @user && @user.logged_in
        render json: @user
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: { message: "You have successfully signed up #{@user.name}"}
    else
      render json: @user.errors
    end
  end

  def update
    if @user && @user.logged_in
      if @user.update(user_params)
        render json: { message: "user updated!"}
      else
        render json: @user.errors
      end
    end
  end

  def destroy
    if @user && @user.logged_in
      @user.destroy
      render json: { message: "user deleted" }
    end
  end

  private

    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end

end