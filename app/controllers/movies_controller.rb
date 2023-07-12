class MoviesController < ApplicationController
  def index
    @movie_list = Movie.all
  end
end
