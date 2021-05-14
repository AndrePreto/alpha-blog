class PagesController < ApplicationController
  
  # GET / -> root
  def home
    @articles = Article.limit(3).order("RANDOM()")
  end

  # GET /about
  def about; end
end