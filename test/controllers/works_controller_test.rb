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

  describe "edit" do
    # What happens if it saves successfuly?
    it "responds ok if the work exists" do
      get edit_work_path(@work)
      must_respond_with :ok
    end

    # What happens if it fails?
    it "responds with not found if the work doesn't exist" do
      work_id = Work.last.id + 1
      get edit_work_path(id: work_id)
      must_respond_with :not_found
      #must_respond_with :not_found
    end
  end

  describe "update" do
    let(:work_data) {
      {
        work: {
          title: "changed",
        },
      }
    }
    it "can update data on the model" do

      # Assumptions
      @work.assign_attributes(work_data[:work])
      expect(@work).must_be :valid?
      @work.reload

      # Act
      patch work_path(@work), params: work_data

      # Assert
      must_respond_with :redirect
      must_redirect_to work_path(@work)

      # TODO
      # Check flash here

      @work.reload
      expect(@work.title).must_equal(work_data[:work][:title])
    end

    it "does something if the work is fake" do
      # work_id = Work.last.id + 1
      # patch edit_work_path(id: work_id)
      # must_respond_with :not_found
    end

    it "does something if the work has bad data" do
      # must_respond_with :bad_request
    end
  end
end
