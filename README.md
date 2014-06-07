# TopoSort

Take a hash of elements and their dependencies and sort
them in an order where each element required is before
the elements that require it.

Note. Each element can have only one dependency.

## Installation

Add this line to your application's Gemfile:

    gem 'topo_sort'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install topo_sort

## Example usage

    nodes  = { 'a' => nil, 'b' => 'c', 'c' => 'f', 'd' => 'a', 'e' => 'b', 'f' => nil }

    TopoSort.sort(nodes)
    #=> ["a", "f", "c", "b", "d", "e"]

## Run tests

Run tests with:

    rake
