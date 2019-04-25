class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @albums = Work.top_media("album")
    @books = Work.top_media("book")
    @movies = Work.top_media("movie")
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    successful = @work.save

    if successful
      # Set flash status to success
      flash[:status] = :success
      # Set flash message
      flash[:message] = "Successfuly created #{@work.category}  #{Work.where(category: @work.category).count}"
      # Don't use NOW since we redirect
      redirect_to works_path
    else
      # Set flash.now status to error
      flash.now[:status] = :error
      # Set flash.now message
      flash.now[:message] = "A problem occurred:  Could not create #{@work.category}"
      # Use NOW since we RENDER
      render :new, status: :bad_request
    end
  end

  def show
    # # Grab the id of work we wanna show
    # work_id = params[:id]
    # # Use that id to find work object, assign it a name
    # @work = Work.find_by(id: work_id)

    # If the work doesn't exist, not found!
    unless @work
      head :not_found
    end
  end

  def edit
    # # What's the work id?
    # work_id = params[:id]

    # # What's the work?
    # @work = Work.find_by(id: work_id)

    # Does this work even exist?
    # If not, what happens? head :not_found

    unless @work
      head :not_found
    end
  end

  def update
    # work_id = params[:id]
    # @work = Work.find_by(id: work_id)

    unless @work
      head :not_found
      return
    end

    if @work.update(work_params)
      flash[:status] = :success
      flash[:message] = "Successfully updated #{@work.category} NUMBER HERE"
      redirect_to work_path(@work)
    else
      flash.now[:status] = :error
      flash.now[:message] = "Could not save #{@work.category} NUMBER HERE"
      render :edit, status: :bad_request
    end
  end

  def destroy
    # Find id - done by filter already

    unless @work
      head :not_found
      return
    end

    successful = @work.destroy
    if successful
      flash[:status] = :success
      flash[:message] = "Successfully destroyed work #{@work.id}."
      redirect_to works_path
    end
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by_id(params[:id])
  end
end
