class MoviesController < ApplicationController
  def index
    @movie_list = Movie.released
  end

  def show
    @movie = Movie.find(params[:id])
    @review = @movie.reviews.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      #flash[:notice] = "Movie successfully updated!"
      #flash.alert = "Your alert msg"
      #redirect_to movie_path(@movie)
      #shortcut below
      redirect_to @movie, notice: "Movie successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "Movie successfully updated!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path, status: :see_other, alert: "Movie sucesssfully removed"
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :total_gross, :released_on, :director, :duration, :image_file_name)
  end
end
