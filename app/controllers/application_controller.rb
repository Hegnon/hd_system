class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def authenticate_user!
    token = request.headers['Authorization']&.split(' ')&.last
    return render json: { error: 'Unauthorized' }, status: :unauthorized unless token

    decoded_token = AuthenticationService.decode_token(token)
    return render json: { error: 'Unauthorized' }, status: :unauthorized unless decoded_token

    @current_user = User.find_by(id: decoded_token['user_id'])
    render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
  end
end
