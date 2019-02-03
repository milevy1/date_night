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

  def test_min_works_with_unbalanced_tree
    @tree.insert(1, "Titanic")
    expected = {"Titanic"=>1}

    assert_equal expected, @tree.min
  end

  def test_sort_returns_array_of_movies_in_ascending_ratings
    expected = [{"Johnny English"=>16},
                {"Hannibal Buress: Animal Furnace"=>50},
                {"Bill & Ted's Excellent Adventure"=>61},
                {"Sharknado 3"=>92}]

    assert_equal expected, @tree.sort
  end

  def test_load_returns_number_of_movies_inserted
    assert_equal 99, @tree.load('./data/movies.txt')
  end

end
