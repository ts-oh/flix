class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email_or_username]) ||  User.find_by(username: params[:email_or_username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user, notice: "Welcome back, #{user.name}!"
    else
      flash.now[:alert] = "Invalid email/password combination!"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    @current_user = nil
    redirect_to movies_url, status: :see_other,
    notice: "You are successfully logged out!"
  end

end

