class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authenticate, only: [:show, :update, :destroy]

  def index
    @users = User.all
    render json: @users, each_serializer: AllusersSerializer
  end

  def show
    if @user
      if @user.logged_in && correct_user
        render json: @user
      else
        render json: { message: 'you are not authorized to view this page' }
      end
    else
      render json: { message: 'you are not authorized to view this page' }
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: { message: "You have successfully signed up #{@user.name}"}
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.logged_in && correct_user
      if @user.update(user_params)
        render json: { message: "user updated!"}
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    else
      render json: { message: 'you are not authorized to view this page' }
    end
  end

  def destroy
    if @user.logged_in && correct_user
      @user.destroy
      render json: { message: "user deleted" }
    else
      render json: { message: 'you are not authorized to view this page' }
    end
  end

  private

    def set_user
      @user = User.find_by(id: params[:id])
    end

    def user_params
      params.permit(:name, :email, :password)
    end

    def correct_user
      this_user = set_user
      correct_user = find_user
      this_user == correct_user
    end

end