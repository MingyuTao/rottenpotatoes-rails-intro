class Movie < ActiveRecord::Base
    def self.all_ratings
  # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
  #  movies with those ratings
  # if ratings_list is nil, retrieve ALL movies
      @all_ratings = ['G', 'PG', 'PG-13', 'R']
     
    end
end
