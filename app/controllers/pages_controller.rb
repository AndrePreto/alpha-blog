class PagesController < ApplicationController
  
  # GET / -> root
  def home
    @articles = Article.limit(4).order("RANDOM()")
  end

  # GET /about
  def about; end
end