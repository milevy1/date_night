# Date night project
http://backend.turing.io/module1/projects/date_night

Learning goals: Binary search trees, Measure test coverage with SimpleCov

Requirements:

- Start with:
- insert adds a new node with movie score and movie title.  
- insert returns the deph of the new node in the tree.

```ruby
tree = BinarySearchTree.new
tree.insert(61, "Bill & Ted's Excellent Adventure")
# => 0
tree.insert(16, "Johnny English")
# => 1
tree.insert(92, "Sharknado 3")
# => 1
tree.insert(50, "Hannibal Buress: Animal Furnace")
# => 2
```

- include? - verify or reject the presence of a score in the tree
```ruby
tree.include?(16)
# => true
tree.include?(72)
# => false
```

- depth_of - returns the depth of the tree where a score appears
