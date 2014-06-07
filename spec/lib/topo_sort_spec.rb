require 'spec_helper'

describe TopoSort do
  it "should sort nothing" do
    nodes  = {}
    sorted = TopoSort.sort(nodes)
    sorted.should == []
  end

  it "should sort one node without dependencies" do
    nodes  = {
      a: nil
    }

    sorted = TopoSort.sort(nodes)
    sorted.should == [:a]
  end

  it "should sort several nodes without dependencies" do
    nodes  = {
      a: nil,
      b: nil,
      c: nil
    }

    sorted = TopoSort.sort(nodes)
    sorted.should == [:a, :b, :c]
  end

  it "should sort several nodes with one that has dependency" do
    nodes  = {
      a: nil,
      b: :c,
      c: nil
    }

    sorted = TopoSort.sort(nodes)
    sorted.should == [:a, :c, :b]
  end

  it "should sort several nodes with several nodes that have dependency" do
    nodes  = {
      a: nil,
      b: :c,
      c: :f,
      d: :a,
      e: :b,
      f: nil
    }

    sorted = TopoSort.sort(nodes)
    sorted.should == [:a, :f, :c, :b, :d, :e]
  end

  it "should raise error when node depends on themselve" do
    nodes  = {
      a: nil,
      b: nil,
      c: :c
    }
    expect { TopoSort.sort(nodes) }.to raise_error(TopoSort::SelfDependency, /sort failed: detected self-dependency/)
  end

  it "should raise error when circular dependency is presented" do
    nodes  = {
      a: nil,
      b: :c,
      c: :f,
      d: :a,
      e: nil,
      f: :b
    }
    expect { TopoSort.sort(nodes) }.to raise_error(TopoSort::Cyclic, /sort failed: detected cyclic dependency/)
  end
end
