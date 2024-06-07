class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :authenticate_user!, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    @users = User.page(params[:page]).per(10)
    respond_to do |format|
      format.html { render :index }  # Corrigido para renderizar a view HTML corretamente
      format.json { render json: @users }
    end
  end

  # GET /users/:id
  def show
    respond_to do |format|
      format.html { render :show }  # Corrigido para renderizar a view HTML corretamente
      format.json { render json: @user }
    end
  end

  # GET /users/new
  def new
    @user = User.new
    @profiles = Profile.all.pluck(:name, :id)
  end

  # GET /users/:id/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        token = AuthenticationService.generate_token(@user.id)
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: { token: token }, status: :created }
      else
        format.html { render :new }
        format.json { render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/:id
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render json: { message: 'User updated successfully' }, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :profile_id, :status)
  end
end
