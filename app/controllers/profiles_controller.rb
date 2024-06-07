class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :update, :destroy]

  # GET /profiles
  def index
    @profiles = Profile.page(params[:page]).per(10)
    render json: @profiles
  end

  # GET /profiles/:id
  def show
    render json: @profile
  end

  # POST /profiles
  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      render json: @profile, status: :created
    else
      render json: @profile.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /profiles/:id
  def update
    if @profile.update(profile_params)
      render json: @profile
    else
      render json: @profile.errors, status: :unprocessable_entity
    end
  end

  # DELETE /profiles/:id
  def destroy
    @profile.destroy
    head :no_content
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:name, :description)
  end
end
