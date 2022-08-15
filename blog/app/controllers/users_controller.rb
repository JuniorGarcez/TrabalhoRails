class UsersController < ApplicationController

  skip_before_action :require_login , except:[:show]


  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def index

  end

  def create
    @user = User.new(user_params)
    if @user.save
    flash[:notice] = "Usuário criado com sucesso!"
    redirect_to articles_path
    else
    render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name,:password,:mail)
  end
end
