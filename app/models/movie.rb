class Movie < ActiveRecord::Base
    def self.with_ratings(ratings_list)
  # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
  #  movies with those ratings
  # if ratings_list is nil, retrieve ALL movies
        Movie.select(:rating).distinct.inject([]){|a,m|a.push m.rating}
    end
end
