class AuthController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:login]
  skip_before_action :authenticate_user!, only: [:login]

  def login
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      if user.ativo?
        token = AuthenticationService.generate_token(user.id)
        render json: { token: token }, status: :ok
      else
        render json: { error: 'User is not active' }, status: :unauthorized
      end
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
end



