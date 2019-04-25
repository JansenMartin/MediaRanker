class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  # Has this user logged in before?
  # If yes, set the session to the user id...and welcome them!
  # If no, create a new user...THEN set the session to user id, and welcome them!

  # What if there's an error?
  # Redirect to login_form
end
