include ActionController::HttpAuthentication::Token::ControllerMethods

class ApplicationController < ActionController::API
  include ActionController::Serialization

  rescue_from Exception, with: :render_500

  before_filter :add_allow_credentials_headers

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token    
    authenticate_with_http_token do |token, options|
      @user = User.find_by(token: token)
    end
  end

  def authenticate_by_param
    @user = User.find_by_token(params[:token])
  end

  def render_unauthorized
    render json: {message: "pls login to access page"}
  end

  def find_user
    authenticate_token || authenticate_by_param
    render json: { message: 'you are not authorized to view this page' } unless @user
  end

  def add_allow_credentials_headers
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Credentials'] = 'true'
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end

  def render_500
    render json: { error: "internal server error", status: 500 }, status: 500
  end
end
