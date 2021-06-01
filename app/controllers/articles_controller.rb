class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user
  before_action :require_current_user, only: [:edit, :update, :destroy]

  # GET /articles
  def index
    @articles = Article.order('id desc').paginate(page: params[:page], per_page: 5)
  end

  # GET /articles/:id
  def show; end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # POST /articles
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    return render "new" unless @article.save

    flash[:notice] = "Article was created successfully."
    redirect_to @article
  end

  # GET /articles/:id/edit
  def edit; end

  # PUT /articles/:id
  def update
    return render "edit" unless @article.update(article_params)

    flash[:notice] = "Article was updated successfully."
    redirect_to @article
  end

  # DELETE /articles/:id
  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find_by(id: params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_current_user
    return if current_user == @article.user || current_user.admin?

    flash[:alert] = 'You can only edit or delete your own articles'
    redirect_to @article
  end

end
