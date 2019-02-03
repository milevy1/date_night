class BinarySearchTree
  attr_reader :rating, :movie, :tree_depth
  attr_accessor :left, :right

  def initialize(rating = nil, movie = nil, tree_depth = 0)
    @rating = rating
    @movie = movie
    @movie_rating_hash = {@movie=>@rating}
    @tree_depth = tree_depth
    @left = nil
    @right = nil
  end

  def insert(new_rating, new_movie)
    # First rating added, @rating will be nil
    if @rating.nil?
      @rating = new_rating
      @movie = new_movie
      @movie_rating_hash = {@movie=>@rating}
      return @tree_depth
    # Error check for rating that already exists
    elsif new_rating == @rating
      puts "Error, the rating #{new_rating} for #{new_movie} is already in use."
    # Left insert
    elsif new_rating < @rating
      if @left.nil?
        @left = BinarySearchTree.new(new_rating, new_movie, @tree_depth + 1)
        return @tree_depth + 1
      else
        @left.insert(new_rating, new_movie)
      end
    # Right insert
    elsif new_rating > @rating
      if @right.nil?
        @right = BinarySearchTree.new(new_rating, new_movie, @tree_depth + 1)
        return @tree_depth + 1
      else
        @right.insert(new_rating, new_movie)
      end
    end
  end

  def depth_of(rating_query)
    if @rating == rating_query
      return @tree_depth
    elsif rating_query < @rating
      @left.depth_of(rating_query)
    elsif rating_query > @rating
      @right.depth_of(rating_query)
    end
  end

  def max
    if @right.nil?
      {@movie => @rating}
    else
      @right.max
    end
  end

  def min
    if @left.nil?
      {@movie => @rating}
    else
      @left.min
    end
  end

  def sort
    sorted_array = []
    if !@rating.nil?
      sorted_array << @left.sort if !@left.nil?
      sorted_array << @movie_rating_hash
      sorted_array << @right.sort if !@right.nil?
    end
    return sorted_array.flatten
  end

  def load(filename)
    data = CSV.read(filename)
    data.each { |rating_movie_data|
      rating_data = rating_movie_data[0].to_i
      movie_data = rating_movie_data[1][1..-1]
      insert(rating_data, movie_data)
    }
    # require "pry"; binding.pry
    return data.length
  end

end
