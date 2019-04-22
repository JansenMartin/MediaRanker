class HomepagesController < ApplicationController
  def index
    @num_of_works = Work.all.count
  end
end
