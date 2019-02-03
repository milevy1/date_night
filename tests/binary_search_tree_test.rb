require 'minitest/autorun'
require 'minitest/pride'
require './lib/binary_search_tree'
require 'csv'

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
    tree = BinarySearchTree.new
    assert_equal 99, tree.load('./data/movies.txt')
  end

  def test_health_of_tree
    skip
    tree = BinarySearchTree.new
    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")

    assert_equal [[98, 7, 100]], tree.health(0)
    assert_equal [[58, 6, 85]], tree.health(1)
    assert_equal [[36, 2, 28], [93, 3, 42]], tree.health(2)
  end

  def test_child_nodes_of_tree
    tree = BinarySearchTree.new
    tree.insert(98, "Animals United")
    tree.insert(58, "Armageddon")
    tree.insert(36, "Bill & Ted's Bogus Journey")
    tree.insert(93, "Bill & Ted's Excellent Adventure")
    tree.insert(86, "Charlie's Angels")
    tree.insert(38, "Charlie's Country")
    tree.insert(69, "Collateral Damage")

    assert_equal 7, tree.child_nodes
    assert_equal 6, tree.left.nodes
  end

end
