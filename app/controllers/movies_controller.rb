class MoviesController < ApplicationController
  before_action :require_signin, except: %i[index show]
  before_action :require_admin, except: %i[index show]

  def index
    @movies = case params[:filter]
              when 'upcoming'
                Movie.upcoming
              when 'recent'
                Movie.recent
              when 'hits'
                Movie.hits
              when 'flops'
                Movie.flops
              else
                Movie.released
              end
  end

  def show
    @movie = Movie.find(params[:id])
    @review = @movie.reviews.new
    @fans = @movie.fans
    @genres = @movie.genres.order(:name)
    return unless current_user

    @favorite = current_user.favorites.find_by(movie_id: @movie.id)
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      # flash[:notice] = "Movie successfully updated!"
      # flash.alert = "Your alert msg"
      # redirect_to movie_path(@movie)
      # shortcut below
      redirect_to @movie, notice: 'Movie successfully updated!'
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
      redirect_to @movie, notice: 'Movie successfully updated!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path, status: :see_other, alert: 'Movie sucesssfully removed'
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :total_gross, :released_on, :director, :duration,
                                  :image_file_name, genre_ids: [])
  end
end

=begin
Dynamic way using ruby send

  def index
    @movies = Movie.send(movies_filter)
  end

  private
  def movies_filter
    if params[:filter].in? %w(upcoming recent hits flops)
      params[:filter]
    else
      :released
    end
  end

But do not do this below!

  def index
    if params[:filter]
      @movies = Movie.send(params[:filter])
    else
      @movies = Movie.released
    end
  end
=end