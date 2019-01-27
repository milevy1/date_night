class BinarySearchTree
  attr_reader :rating, :movie, :tree_depth
  attr_accessor :left, :right

  def initialize(rating = nil, movie = nil, tree_depth = 0)
    @rating = rating
    @movie = movie
    @tree_depth = tree_depth
    @left = nil
    @right = nil
  end

  def insert(new_rating, new_movie)
    # First rating added, @rating will be nil
    if @rating.nil?
      @rating = new_rating
      @movie = new_movie
      return @tree_depth
    # Error check for rating that already exists
    elsif new_rating == @rating
      puts "Error, that rating is already in use."
    # Left insert
    elsif new_rating < @rating
      if @left.nil?
        @left = BinarySearchTree.new(new_rating, new_movie, @tree_depth + 1)
        return @tree_depth + 1
      else
        @left.insert(new_rating, new_movie)
      end
    elsif new_rating > @rating
      if @right.nil?
        @right = BinarySearchTree.new(new_rating, new_movie, @tree_depth + 1)
        return @tree_depth + 1
      else
        @right.insert(new_rating, new_movie)
      end
    end
  end

end
