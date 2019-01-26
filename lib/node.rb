class Node
  attr_reader :value
  attr_accessor :left, :right

  def initialize(value = nil)
    @valiue = value
    @left = nil
    @right = nil
  end

end
