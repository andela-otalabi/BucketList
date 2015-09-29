class ApplicationController < ActionController::API
  include ActionController::Serialization
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_filter :add_allow_credentials_headers


  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
     authenticate_with_http_token do |token, options|
      User.find_by(token: token)
    end
  end

  def render_unauthorized
    render json: {message: "pls login to access page"}
  end

  def add_allow_credentials_headers
    response.headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'
    response.headers['Access-Control-Allow-Credentials'] = 'true'
  end
end
