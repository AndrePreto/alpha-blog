class ArticlesController < ApplicationController
  before_action :set_article, olny: [:show]

  # GET /articles
  def index
    @articles = Article.all
  end

  # GET /articles/:id
  def show
    @article
  end

  private

  def set_article
    @article = Article.find_by(id: params[:id])
  end
end
