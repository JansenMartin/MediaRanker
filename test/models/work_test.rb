require "test_helper"

describe Work do
  before do
    @work = works(:toy_story)
  end

  it "passes validations with good data" do
    expect(@work).must_be :valid?
  end

  describe "index_media" do
    it "returns a collection of works with the same category type" do
      # Arrange / Act
      movie_collection = Work.index_media("movie")
      book_collection = Work.index_media("book")
      album_collection = Work.index_media("album")

      # Assert
      expect(movie_collection.count).must_equal Work.where(category: "movie").count
      expect(book_collection.count).must_equal Work.where(category: "book").count
      expect(album_collection.count).must_equal Work.where(category: "album").count
    end

    it "returns an empty list if there are no works in the database" do
      Work.destroy_all

      movie_collection = Work.index_media("movie")
      book_collection = Work.index_media("book")
      album_collection = Work.index_media("album")

      expect(movie_collection.count).must_equal 0
      expect(book_collection.count).must_equal 0
      expect(album_collection.count).must_equal 0
    end
  end
end
