class LoginsController < ApplicationController
  skip_before_action :require_login , except:[:logout]

  def new
  end

  def create
    @user_session = User.where(name: params["name"]).where(password: params["password"])
    if @user_session.blank?
      flash[:alert] = "Usuário inválido!"
    else
      session[:current_user_id] = @user_session.first.id
      flash[:notice] = "Bem-Vindo #{current_user.name}!!"
    end
    redirect_to root_path
  end

  def logout
    session[:current_user_id] = nil
    flash[:alert] = "Você saiu da sessão!"
    redirect_to root_path
  end
end
