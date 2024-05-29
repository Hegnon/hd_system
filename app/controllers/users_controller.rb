class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :update]
  skip_before_action :authenticate_user!, only: [:create]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.page(params[:page]).per(10)
    render json: @users
  end

  # GET /users/:id
  def show
    render json: @user
  end

  # POST /users
  def create
    user = User.new(user_params)
    if user.save
      token = AuthenticationService.generate_token(user.id)
      render json: { token: token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/:id
  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: { message: 'User updated successfully' }, status: :ok
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :profile_id, :status)
  end
end
