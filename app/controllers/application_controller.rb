class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def authenticate_user!
    token = request.headers['Authorization']&.split(' ')&.last
    user_info = AuthenticationService.decode_token(token)
    @current_user = User.find(user_info['user_id']) if user_info
    render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
  end
end