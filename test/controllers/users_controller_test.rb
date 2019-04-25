require "test_helper"

describe UsersController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end

  describe "login_form" do
    it "renders without crashing" do
      # Arrange

      # Act
      get login_path

      # Assert
      must_respond_with :ok
    end
  end

  describe "login" do
    it "adds a new user to the database" do
      # Arrange
      user_data = {
        user: {
          username: "new_user",
        },
      }

      # Act
      expect {
        post "/login", params: user_data
      }.must_change "User.count", +1

      # Assert
      # must_redirect_to root_path

      user = User.last
      expect(user.username).must_equal user_data[:user][:username]
    end

    it "doesn't add an existing user to the database" do
    end
  end
end
