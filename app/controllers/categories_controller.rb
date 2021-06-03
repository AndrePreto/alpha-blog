class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :require_user
  before_action :require_admin_user, except: [:index, :show] 

  # GET /categories
  def index
    @categories = Category.order('id desc').paginate(page: params[:page], per_page: 5)
    @articles_count = ArticleCategory.where(category_id: @categories.ids).group(:category_id).count
  end
  
  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/:id
  def show
    @articles = @category.articles.order('id desc').paginate(page: params[:page], per_page: 5)
  end

  # POST /categories
  def create
    @category = Category.new(category_params)
    return render 'new' unless @category.save

    flash[:notice] = 'Article Category created successfully'
    redirect_to @category
  end

  # GET /categories/:id/edit
  def edit; end

  # PUT /categories/:id
  def update
    return render 'edit' unless @category.update(category_params)

    flash[:notice] = 'Article Category updated successfully'
    redirect_to @category
  end

  # DELETE /categories/:id
  def destroy
    @category.destroy
    redirect_to categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin_user
    return if current_user.admin?
    flash[:alert] = "You're not allowed to perform that action"
    redirect_to categories_path
  end

end