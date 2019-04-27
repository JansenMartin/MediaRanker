class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  def login
    # What's the user's username?
    username = params[:user][:username]
    @user = User.find_by(username: username)

    # Has this user logged in before?
    if @user
      #  If yes, set the session to the user id...and welcome them!
      session[:user_id] = User.find_by(id: @user.id)
      flash[:status] = :success
      flash[:message] = "Welcome back, #{username}!"
    else
      @user = User.new(user_params)
      unless @user.save
        render :login_form
        return
      else
        session[:user_id] = User.find_by(id: @user.id)
        flash[:status] = :success
        flash[:message] = "Nice to meet you, #{username}!"
      end
    end

    redirect_to root_path
  end

  def logout
    flash[:status] = :success
    flash[:message] = "Successfully logged out!  See you later, 'gator."
    session[:user_id] = nil

    redirect_to root_path
  end

  private

  def user_params
    return params.require(:user).permit(:username)
  end
end
