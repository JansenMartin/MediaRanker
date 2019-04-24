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

    it "creates a new work" do
      # What happens if I successfully save to DB?

      # Arrange
      # Gimme some work data
      work_data = {
        work: {
          category: "Test Cat",
          title: "Test Title",
          creator: "Test Creator",
          publication_year: "Test Year",
          description: "Test description ah-yep!",
        },
      }

      # Act
      # Expect...
      expect {
        post works_path, params: work_data
      }.must_change "Work.count", +1

      # Assert
      must_respond_with :redirect
      must_redirect_to works_path
    end

    it "sends back bad_request if given no work data" do
      # What happens if I don't feed it any data?

      # Arrange
      # Blank book data!
      work_data = {
        work: {
          category: "",
        },
      }

      # Assumption
      expect(Work.new(work_data[:work])).wont_be :valid?

      # Act
      expect {
        post works_path, params: work_data
      }.wont_change "Work.count"
      # Expect...
      # Post to works_path, with work_data for params...
      # won't change Work count

      # Assert
      must_respond_with :bad_request
      # must respond with :bad_request
    end
  end
end
