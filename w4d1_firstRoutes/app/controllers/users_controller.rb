class UsersController < ApplicationController

  def index
    @users = User.all
    render json: @users
  end

  def create
    user = User.new(params[:user].permit(:name, :email))
    if user
      user.save!
      render json: user
    else
      render(
      json: user.errors.full_messages, status: :unprocessable_entity
          )
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user
      render json: @user
    else
      render json:["Couldn't find user"], status: 400
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    update_params = (params[:user].permit(:name, :email))
    if @user.update_attributes(update_params)
      render json: @user
    else
      render(
      json: user.errors.full_messages, status: :unprocessable_entity
          )
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    if @user.delete
      render json: @user
    else
      render(
      json: user.errors.full_messages, status: :unprocessable_entity
          )
    end
  end
end
