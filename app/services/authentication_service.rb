require 'jwt'

class AuthenticationService
  def self.generate_token(user_id)
    JWT.encode({ user_id: user_id }, Rails.application.secret_key_base)
  end

  def self.decode_token(token)
    JWT.decode(token, Rails.application.secret_key_base).first
  rescue JWT::DecodeError
    nil
  end
end
