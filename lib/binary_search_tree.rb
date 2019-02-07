class BinarySearchTree
  attr_reader :rating, :movie, :tree_depth
  attr_accessor :left, :right

  def initialize(rating = nil, movie = nil, tree_depth = 0, head_node = "HEAD")
    @rating = rating
    @movie = movie
    @movie_rating_hash = {@movie=>@rating}
    @tree_depth = tree_depth
    @left = nil
    @right = nil
    @head_node = head_node
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
        @left = BinarySearchTree.new(new_rating, new_movie, @tree_depth + 1, self)
        return @tree_depth + 1
      else
        @left.insert(new_rating, new_movie)
      end
    # Right insert
    elsif new_rating > @rating
      if @right.nil?
        @right = BinarySearchTree.new(new_rating, new_movie, @tree_depth + 1, self)
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

  # def sort
  #   sorted_array = []
  #   if !@rating.nil?
  #     sorted_array << @left.sort if !@left.nil?
  #     sorted_array << @movie_rating_hash
  #     sorted_array << @right.sort if !@right.nil?
  #   end
  #   return sorted_array.flatten
  # end

  def sort
    if !@left.nil?
      left = @left.sort
    else
      left = []
    end

    if !@right.nil?
      right = @right.sort
    else
      right = []
    end

    return left + [@movie_rating_hash] + right
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

  def health(level, total_nodes = child_nodes)
    health_array = []

    # total_nodes = child_nodes if @tree_depth == 0
    if level == 0
      health_array << [@rating, child_nodes, (child_nodes / total_nodes.to_f * 100).floor]

      return health_array
    end
    health_array << @left.health(level - 1, total_nodes) if !@left.nil?
    health_array << [] if @left.nil?
    health_array << @right.health(level - 1, total_nodes) if !@right.nil?
    health_array << [] if @right.nil?

    health_array.flatten!(1)

    return health_array
  end

  def child_nodes
    total = 1
    total += @left.child_nodes if !@left.nil?
    total += @right.child_nodes if !@right.nil?

    return total
  end

  def leaves
    return 1 if @left.nil? && @right.nil?

    if !@left.nil? && !@right.nil?
      return @left.leaves + @right.leaves
    elsif !@left.nil?
      return @left.leaves
    elsif !@right.nil?
      return @right.leaves
    end

  end

  def delete(rating)
    current_node = self

    while current_node.rating != rating
      if rating < current_node.rating
        #do something to left
        current_node = current_node.left
      else
        current_node = current_node.right
      end
    end

  end

end
