class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

  before_action :require_login

  helper_method :current_user

  private

  def require_login
    if session[:current_user_id].blank?
      flash[:error] = "Você precisa iniciar a sessão"
      redirect_to new_login_path
    end
  end

  def current_user
  User.find(session[:current_user_id]) if session[:current_user_id]
  #User.find_by(id: session[:current_user_id])
  end

end
