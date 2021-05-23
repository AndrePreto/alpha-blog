class SessionsController < ApplicationController

  # GET /login (sessions#new)
  def new; end

  # POST /login (sessions#create)
  def create
    user_email = params[:session][:email].downcase
    user_password = params[:session][:password]
    user = User.find_by(email: user_email)
    if user && user.authenticate(user_password)
      session[:current_user_id] = user.id
      flash[:notice] = 'Logged in successfully'
      redirect_to user
    else
      flash.now[:alert] = 'Email or Password incorrect'
      render 'new'
    end
  end

  # DELETE /logout (sessions#destroy)
  def destroy
    session[:current_user_id] = nil
    flash[:notice] = 'Logged out successfully'
    redirect_to root_path
  end
  
end