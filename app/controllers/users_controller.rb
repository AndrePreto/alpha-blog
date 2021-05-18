class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    @users = User.order('id desc').paginate(page: params[:page], per_page: 5)
    @articles_count = Article.where(user_id: @users.ids).group(:user_id).count
  end

  # GET /users/:id
  def show 
    @articles = @user.articles.order('id desc').paginate(page: params[:page], per_page: 5)
  end

  # GET /signup (users#new)
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)
    return render "new" unless @user.save

    flash[:notice] = "Welcome to the Alpha-Blog #{@user.username}, you have successfully signed up"
    redirect_to articles_path
  end

  # GET /users/:id
  def edit; end

  # PUT /users/:id/update
  def update
    return render "edit" unless @user.update(user_params)

    flash[:notice] = "Account was updated successfully."
    redirect_to @user
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
