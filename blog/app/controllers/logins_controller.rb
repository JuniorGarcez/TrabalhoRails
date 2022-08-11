class LoginsController < ApplicationController
  skip_before_action :require_login , except:[:logout]

  def new
  end

  def create
    user = User.where(name: params["name"]).where(password: params["password"])
    if user.blank?
      flash[:alert] = "Usuário inválido!"
    else

      session[:current_user_id] = user.first
      flash[:notice] = "Usuário logado com sucesso!"
    end
    redirect_to root_path
  end

  def logout
    session[:current_user_id] = nil
    flash[:notice] = "Você saiu da sessão!"
    redirect_to root_path
  end
end
