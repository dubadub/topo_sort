require "topo_sort/version"
require 'ostruct'

module TopoSort
  class SelfDependency < StandardError; end
  class Cyclic < StandardError;         end

  extend self

  #Take a hash of elements and their dependencies and sort
  #them in an order where each element required is before
  #the elements that require it.
  #
  #Example usage:
  #
  #   nodes  = { :a => nil, :b => :c, :c => :f, :d => :a, :e => :b, :f => nil }
  #   TopoSort.sort(nodes)
  #   #=> [:a, :f, :c, :b, :d, :e]
  #
  def sort(nodes)
    @sorted   = []

    @vertices = nodes.inject({}) do |memo, (node, dependency)|
      memo[node] = OpenStruct.new(
        name:       node,
        dependency: dependency,
        marked:     false,       #store the vertex has been visited by dfs
        on_stack:   false        #to detect cycle
      )
      memo
    end

    nodes.each{ |(node, dep)| visit(@vertices[node]) unless @vertices[node].marked }

    @sorted
  end

  protected

  def visit(vertice)
    vertice.marked  = true
    vertice.on_stack = true
    if vertice.dependency && dependency = @vertices[vertice.dependency]
      raise SelfDependency.new("sort failed: detected self-dependency for '#{vertice.name}'")             if dependency == vertice
      raise Cyclic.new("sort failed: detected cyclic dependency '#{vertice.name} => #{dependency.name}'") if dependency.on_stack
      visit(dependency) unless dependency.marked
    end
    vertice.on_stack = false

    @sorted.push vertice.name
  end

end

