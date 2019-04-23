class WorksController < ApplicationController
  def index
    @albums = Work.where(category: "album")
    @books = Work.where(category: "book")
    @movies = Work.where(category: "movie")
  end

  def new
    # Make new work!
  end

  def show
    # Grab the id of work we wanna show
    work_id = params[:id]
    # Use that id to find work object, assign it a name
    @work = Work.find_by(id: work_id)

    # If the work doesn't exist, not found!
    unless @work
      head :not_found
    end
  end
end
