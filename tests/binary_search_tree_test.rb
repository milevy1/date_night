require 'minitest/autorun'
require 'minitest/pride'
require './lib/binary_search_tree'

class BinarySearchTreeTest < Minitest::Test

  def setup
    @tree = BinarySearchTree.new
    @tree.insert(61, "Bill & Ted's Excellent Adventure")
    @tree.insert(16, "Johnny English")
    @tree.insert(92, "Sharknado 3")
    @tree.insert(50, "Hannibal Buress: Animal Furnace")
  end

  def test_depth_of_returns_tree_depth_of_rating
    assert_equal 1, @tree.depth_of(92)
    assert_equal 2, @tree.depth_of(50)
  end

  def test_max_returns_highest_score
    expected = {"Sharknado 3"=>92}

    assert_equal expected, @tree.max
  end

  def test_min_returns_lowest_score
    expected = {"Johnny English"=>16}

    assert_equal expected, @tree.min
  end

end
