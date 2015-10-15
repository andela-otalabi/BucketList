include ActionController::HttpAuthentication::Token::ControllerMethods

class ApplicationController < ActionController::API
  include ActionController::Serialization

  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  rescue_from Exception, with: :render_500


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

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, X-Prototype-Version, Token'
      headers['Access-Control-Max-Age'] = '1728000'
    end
  end

  def render_500
    render json: { error: "internal server error", status: 500 }, status: 500
  end
end
