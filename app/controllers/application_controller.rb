include ActionController::HttpAuthentication::Token::ControllerMethods

class ApplicationController < ActionController::API
  include ActionController::Serialization

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
    headers['Access-Control-Expose-Headers'] = 'ETag'
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = '*, Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end

end
