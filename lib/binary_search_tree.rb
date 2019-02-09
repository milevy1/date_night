class BinarySearchTree
  attr_reader :rating, :movie
  attr_accessor :left, :right

  def initialize(rating = nil, movie = nil, head_node = "HEAD")
    @rating = rating
    @movie = movie
    @left = nil
    @right = nil
    @head_node = head_node
  end

  def insert(new_rating, new_movie)
    # First rating added, @rating will be nil
    if @rating.nil?
      @rating = new_rating
      @movie = new_movie
      return 0
    # Error check for rating that already exists
    elsif new_rating == @rating
      puts "Error, the rating #{new_rating} for #{new_movie} is already in use."
    # Left insert
    elsif new_rating < @rating
      if @left.nil?
        @left = BinarySearchTree.new(new_rating, new_movie, self)
        return 1
      else
        return 1 + @left.insert(new_rating, new_movie)
      end
    # Right insert
    elsif new_rating > @rating
      if @right.nil?
        @right = BinarySearchTree.new(new_rating, new_movie, self)
        return 1
      else
        return 1 + @right.insert(new_rating, new_movie)
      end
    end
  end

  def include?(rating)
    return true if @rating == rating

    if !@left.nil? && rating < @rating
      return @left.include?(rating)
    elsif !@right.nil? && rating > @rating
      return @right.include?(rating)
    end
    # If it does not find it, return false
    return false
  end

  def depth_of(rating)
    if @rating == rating
      return 0
    elsif rating < @rating
      return 1 + @left.depth_of(rating)
    elsif rating > @rating
      return 1 + @right.depth_of(rating)
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

    return left + [{@movie => @rating}] + right
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

    # total_nodes = child_nodes if tree_depth == 0
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

  def height(depth = 0)
    return 0 if @rating.nil?

    if !@left.nil?
      lheight = @left.height
    else
      lheight = 0
    end

    if !@right.nil?
      rheight = @right.height
    else
      rheight = 0
    end

    if lheight > rheight
      return lheight + 1
    else
      return rheight + 1
    end

  end

  def delete(rating)
    if !include?(rating)
      puts "Rating does not exist"
      return rating
    end

    if rating == @rating
      @rating = remove(rating)
    elsif rating < @rating
      @left = delete(rating)
    else
      @right = delete(rating)
    end
    

  end

  def delete_node(tnode,node)
     if tnode == node
        tnode = remove(tnode)
     elsif node < tnode
        tnode.left = delete_node(tnode.left,node)
     else
        tnode.right = delete_node(tnode.right,node)
     end
    tnode
 end

 def remove(node)
   if node.left.nil? && node.right.nil?
      node = nil
   elsif !node.left.nil? && node.right.nil?
      node = node.left
   elsif node.left.nil? && !node.right.nil?
      node = node.right
   else
      node = replace_parent(node)
   end
  node
 end

end
