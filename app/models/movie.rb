class Movie < ActiveRecord::Base
    def Movie.ratings
        Movie.select(:rating).distinct.inject([]){|a,m|a.pushing m.rating}
    end
end
