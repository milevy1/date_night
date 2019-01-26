class Node
  attr_reader :value
  attr_accessor :left, :right

  def initialize(value = nil)
    @value = value
    @left = nil
    @right = nil
  end

end

class BinarySearchTree
  attr_accessor :root_node

  def initialize(root_value = nil)
    @root_node = Node.new(root_value)
  end

  def insert(node, value)
    if node.value == value
      return node
    elsif value < node.value
      insert(node.left, value)
    elsif value > node.value
      insert(node.right, value)
    else
      return node = Node.new(value)
    end
  end

end
