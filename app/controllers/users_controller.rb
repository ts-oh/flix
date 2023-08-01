class UsersController < ApplicationController
  before_action :require_signin, except: %i[new create]
  before_action :require_correct_user, only: %i[show edit update destroy]
  before_action :require_admin, only: [:destroy]

  def index
    @users = User.not_admins
  end

  def show
    @reviews = @user.reviews
    @favorite_movies = @user.favorite_movies
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: 'Signup successfull!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Account successfully updated!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to root_url, status: :see_other, alert: 'Account succesfully deleted!'
  end

  private

  # this will run before above actions hence we can delete @user = User.find from actions related to require_correct_user
  def require_correct_user
    @user = User.find_by!(username: params[:id])
    redirect_to root_url, status: :see_other unless current_user?(@user)
  end

  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :pasword_confirmation)
  end

end
