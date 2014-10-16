class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  before_filter :authenticate_user, :track
  before_filter :remote_cant_access, except: [:index, :show]
  before_filter :http_basic_auth, :if => :http_basic_auth_required?

  private

  def http_basic_auth
    authenticate_or_request_with_http_basic do |id, password|
      id == ENV['DEMO_USER'] && password == ENV['DEMO_PASSWORD']
    end
  end

  def http_basic_auth_required?
    Rails.env.staging?
  end


  def authenticate_user
    redirect_to welcome_path unless current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def track
    Log.create_for(current_user) if current_user
  end

  def remote_cant_access
    if current_user.remote?
      flash[:notice] = I18n.t('notice.cant_access')
      redirect_to root_path
    end
  end
end
