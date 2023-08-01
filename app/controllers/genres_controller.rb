class GenresController < ApplicationController
  before_action :set_genre, only: :show

  def index
    @genres = Genre.all
  end

  def show; end

  private

  def set_genre
    @genre = Genre.find_by!(slug: params[:id])
  end
end
