class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

  before_action :require_login

  private

  def require_login
    if session[:current_user_id].blank?
      flash[:error] = "Você precisa iniciar a sessão"
      redirect_to articles_path # halts request cycle
    end
  end

end
