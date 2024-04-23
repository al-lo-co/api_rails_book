class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]
  before_action :check_owner, only: %i[ update destroy ]

  def index
    users = User.all
    render json: UserBlueprint.render(users, view: :extended)
  end

  def show
    render json: UserBlueprint.render(@user, view: :extended)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: UserBlueprint.render(@user, view: :extended), status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: UserBlueprint.render(@user, view: :extended), status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @user && @user.destroy
      @status = 204
    else
      @status = :unprocessable_entity
    end

    head @status
  end

  private

  def check_owner
    head :forbidden unless @user.id == current_user&.id
  end

  def set_user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
