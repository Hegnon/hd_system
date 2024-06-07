class AuthController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:login]
  skip_before_action :authenticate_user!, only: [:login]

  def login
    if request.post?
      user = User.find_by(email: params[:email])
      if user&.authenticate(params[:password])
        if user.ativo?
          token = AuthenticationService.generate_token(user.id)
          session[:user_id] = user.id
          session[:token] = token
          response.set_header('Authorization', "Bearer #{token}")
          redirect_to users_path, notice: 'Login successful!'
        else
          flash.now[:alert] = 'User not active'
          render :login
        end
      else
        flash.now[:alert] = 'Invalid email or password'
        render :login
      end
    else
      render :login
    end
  end

  def logout
    session[:user_id] = nil
    session[:token] = nil
    redirect_to auth_login_path, notice: 'Logged out!'
  end
end
