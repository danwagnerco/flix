class UsersController < ApplicationController
  before_action :require_signin, :except => [:new, :create]
  before_action :require_correct_user, :only => [:edit, :update, :destroy]
  # code below would only allow admins to delete user accounts
  # before_action :require_admin, :only => [:destroy]

  def index
    @users = User.all
    # if we only wanted to show non-admins, we could write:
    # @users = User.no_admins_by_name
  end

  def show
    @user            = User.find(params[:id])
    @reviews         = @user.reviews
    @favorite_movies = @user.favorite_movies
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, :notice => "Thanks for signing up!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, :notice => "Account successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    # code below would only allow admins to delete user accounts
    # @user = User.find(:params[:id])
    # @user.destroy
    # redirect_to root_url, :notice => "Account successfully deleted!"
    @user.destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Account successfully deleted!"
  end

private

  def require_correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user)
  end

  def user_params
    params.require(:user).permit(:name, :email, :username, :password, :password_confirmation)
  end

end
