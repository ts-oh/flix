class MoviesController < ApplicationController
  def index
    @movie_list = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end
end
