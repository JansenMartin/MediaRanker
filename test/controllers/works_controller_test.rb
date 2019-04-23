require "test_helper"

describe WorksController do
  it "can get the index" do
    # Arrange

    # Act
    get works_path

    # Assert
    must_respond_with :ok
  end
end
