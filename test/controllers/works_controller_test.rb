require "test_helper"

describe WorksController do
  before do
    @work = Work.first
  end
  it "can get the index" do
    # Arrange

    # Act
    get works_path

    # Assert
    must_respond_with :ok
  end

  describe "show" do
    it "returns a 404 status if the work doesn't exist" do
      # Arrange
      bogus_work_id = 9001

      # Act
      get work_path(bogus_work_id)

      # Assert
      must_respond_with :not_found
    end

    it "works for a work that exists" do
      # Arrange

      # Act
      get work_path(@work.id)

      # Assert
      must_respond_with :ok
    end
  end

  describe "new" do
    # It can make a new thing (returns status code 200)
    it "returns status code 200" do
      # Act/ Arrange
      get new_work_path

      # Assert
      must_respond_with :ok
    end
  end
end
