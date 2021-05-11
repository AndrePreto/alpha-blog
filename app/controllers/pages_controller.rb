class PagesController < ApplicationController
  
  def home
    @articles = Article.limit(3).order("RANDOM()")
  end

  def about; end
end