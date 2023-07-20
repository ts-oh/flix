module MoviesHelper
  def total_gross(movie)
    if movie.flop?
      'Flop!'
    else
      number_to_currency(movie.total_gross, precision: 0)
    end
  end

  def description(movie)
    truncate(movie.description, length: 150, seperator: ' ')
  end

  def release_year(movie)
    movie.released_on.year
  end
end
