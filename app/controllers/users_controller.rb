class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:new, :create]
  before_action :require_current_user, only: [:edit, :update]

  # GET /users
  def index
    @users = User.order('created_at desc').paginate(page: params[:page], per_page: 5)
    @articles_count = Article.where(user_id: @users.ids).group(:user_id).count
  end

  # GET /users/:id
  def show 
    @articles = @user.articles.includes(:categories).order('id desc').paginate(page: params[:page], per_page: 5)
  end

  # GET /signup (users#new)
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)
    return render "new" unless @user.save

    session[:current_user_id] = @user.id
    flash[:notice] = "Welcome to the Alpha-Blog #{@user.username}, you have successfully signed up"
    redirect_to articles_path
  end

  # GET /users/:id
  def edit; end

  # PUT /users/:id
  def update
    return render "edit" unless @user.update(user_params)

    flash[:notice] = "Account was updated successfully."
    redirect_to @user
  end

  # DELETE /users/:id
  def destroy
    redirect_path = current_user.admin? && current_user != @user ? users_path : root_path
    @user.destroy
    session[:current_user_id] = nil if current_user == @user 
    flash[:notice] = 'Profile and all articles associated successfully deleted'
    redirect_to redirect_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_current_user
    return if current_user == @user || current_user.admin?
    flash[:alert] = 'You can only edit or delete your own profile'
    redirect_to @user
  end

end
