require "test_helper"

describe HomepagesController do
  it "renders without crashing" do
    # Arrange

    # Act
    get root_path

    # Assert
    must_respond_with :ok
  end
end
