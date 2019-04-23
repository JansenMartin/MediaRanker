class HomepagesController < ApplicationController
  def index
    @works = Work.all

    @media_spotlight = @works.sample

    @top_movies = @works.where(category: "movie").sample(10)
    @top_books = @works.where(category: "book").sample(10)
    @top_albums = @works.where(category: "album").sample(10)
  end
end
