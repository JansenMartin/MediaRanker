class WorksController < ApplicationController
  def index
    @albums = Work.where(category: "album")
    @books = Work.where(category: "book")
    @movies = Work.where(category: "movie")
  end

  def new
    @work = Work.new
  end

  def create
    # Create a new instance of Work using work_params

    # If it saves successfully, redirect to works_path
    # Otherwise, render :new, status: :bad_request

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

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
