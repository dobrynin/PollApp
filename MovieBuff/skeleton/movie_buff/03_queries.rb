def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.
  Movie
    .select("movies.title, movies.id")
    .joins(:actors)
    .where("actors.name IN (?)", those_actors)
    .group("movies.id")
    .having("COUNT(*) >= (?)", those_actors.length)

end

def golden_age
  # Find the decade with the highest average movie score.
  Movie
    .group("yr / 10")
    .order("AVG(score) DESC")
    .pluck("(yr / 10) * 10").first
end

def costars(name)
  # List the names of the actors that the named actor has ever appeared with.
  # Hint: use a subquery

  movies = Movie
  .joins(:actors)
  .where("actors.name = (?)", name)
  .pluck("movies.id")

  Actor
    .joins(:castings)
    .where("castings.movie_id IN (?) AND actors.name != (?)", movies, name)
    .pluck("DISTINCT(actors.name)")

end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor
    .joins("LEFT OUTER JOIN castings ON castings.actor_id = actors.id")
    .where("castings.actor_id IS NULL")
    .pluck("COUNT(*)")
    .first
end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the letters in whazzername,
  # ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but not like "stallone sylvester" or "zylvester ztallone"
  whazzername = "%" + whazzername.split("").join("%") + "%"
  Movie
    .joins(:actors)
    .where("UPPER(actors.name) LIKE UPPER(?)", whazzername)

end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of their career.

end
