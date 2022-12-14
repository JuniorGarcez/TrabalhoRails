class ArticlesController < ApplicationController
  skip_before_action :require_login , only:[:index, :show]

  before_action :autentic_id, except:[:index, :show, :new, :create]

  def destroy
    @article = Article.find(params[:id])
    autentic_id
    @article.destroy
    redirect_to articles_path
  end

  def index
    @limit_page = 4
    @articles_count = Article.count
    @pages = (@articles_count % @limit_page == 0) ? (@articles_count / @limit_page) -1 : (@articles_count / @limit_page)
    @page = params.fetch(:page, 0).to_i
    @articles = Article.search(params[:search]).offset(@page * @limit_page).limit(@limit_page)
    @page + 0 == 0 ? @artilce_ini = 1 : @artilce_ini = (@page * @limit_page) + 1
    @page == @pages ? @article_fim = @articles_count : @article_fim = (@page + 1) * @limit_page
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
    autentic_id
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
    autentic_id
    if @article.update(article_params)
      flash[:notice] = "Artigo atualizado com sucesso!!"
      redirect_to articles_path
    else
      render 'edit'
    end
  end
end


private
def article_params
  params.require(:article).permit(:title,:text)
end

def autentic_id
  @article = Article.find(params[:id])
  unless @article.user_id == current_user.id
    redirect_to articles_path
    flash[:alert] = "Você não tem permissão para executar a solicitação."
  end
end
