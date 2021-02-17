class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
  
 
  def index
    @sort = params[:sort]
    @ratings = params[:ratings]
    @movies = Movie.all.order(@sort)
    
    @all_ratings = Movie.all_ratings
     redirect = false

     logger.debug(session.inspect)

         if params[:sort]
          @sort = params[:sort]
          session[:sort] = params[:sort]
        elsif session[:sort]
          @sort = session[:sort]
          redirect = true
        else
          @sort_by = nil
        end

        if params[:commit] == "Refresh" and params[:rating].nil?
          @ratings = nil
          session[:ratings] = nil
        elsif params[:ratings]
          @ratings = params[:ratings]
          session[:ratings] = params[:ratings]
        elsif session[:ratings]
          @ratings = session[:ratings]
          redirect = true
        else
          @ratings = nil
        end

        if redirect
          flash.keep
          redirect_to movies_path :sort=>@sort, :ratings=>@ratings
        end    

        if @ratings and @sort
          @movies = Movie.where(:rating => @ratings.keys).order(@sort)
        elsif @ratings
          @movies = Movie.where(:rating => @ratings.keys)
        elsif @sort
          @movies = Movie.order(@sort)
        else 
          @movies = Movie.all
        end

        if !@ratings
          @ratings = Hash.new
        end

  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  
  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end