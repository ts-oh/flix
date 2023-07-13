module MoviesHelper

  def performance(movie)
    if movie.flop?
      "Flop!"
    else
      number_to_currency(movie.total_gross, precision: 0)
    end
  end

  def description(movie)
    truncate(movie.description, length: 40, seperator: ' ')
  end

  def release_year(movie)
    movie.released_on.year
  end

end
