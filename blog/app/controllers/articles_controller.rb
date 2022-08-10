class ArticlesController < ApplicationController
  http_basic_authenticate_with name: "Admin", password: "root", except: [:index, :show]

  def destroy
     @article = Article.find(params[:id])
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
  end

  def create
    @article = Article.new(article_params)
    if @article.save
    redirect_to @article
  else
    render 'new'
  end
  end

  def update
    @article = Article.find(params[:id])

      if @article.update(article_params)
        redirect_to @article
      else
        render 'edit'
      end
    end
  end

  private
  def article_params
    params.require(:article).permit(:title,:text)
  end
