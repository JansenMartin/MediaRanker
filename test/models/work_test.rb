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

  describe "top_media" do
    before do
      @top_movies = Work.top_media("movie")
    end
    it "returns a list of 10 Work objects" do
      movie = @top_movies.first

      expect(movie).must_be_kind_of Work
      expect(@top_movies.count).must_equal 10
    end

    it "returns a list of 10 movies, even if there are more than 10 of them" do
      movies_count = Work.where(category: "movie").count

      expect(@top_movies.count).must_equal 10
      expect(movies_count > 10).must_equal true
    end

    it "returns an empty list if there are no works in the database" do
      Work.destroy_all

      top_movies = Work.top_media("movie")
      top_books = Work.top_media("book")
      top_albums = Work.top_media("album")

      expect(top_movies.count).must_equal 0
      expect(top_books.count).must_equal 0
      expect(top_albums.count).must_equal 0
    end
  end
end
