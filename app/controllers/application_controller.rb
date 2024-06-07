class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def authenticate_user!
    token = session[:token] || request.headers['Authorization']&.split(' ')&.last
    unless token
      redirect_to auth_login_path, alert: 'Unauthorized access. Please log in.'
      return
    end

    decoded_token = AuthenticationService.decode_token(token)
    unless decoded_token
      redirect_to auth_login_path, alert: 'Invalid token. Please log in again.'
      return
    end

    @current_user = User.find_by(id: decoded_token['user_id'])
    unless @current_user
      redirect_to auth_login_path, alert: 'Invalid user. Please log in again.'
    end
  end
end
