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
end
