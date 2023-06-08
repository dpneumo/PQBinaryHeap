# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/pq_binary_heap'
require_relative '../lib/item'

class PQBinaryHeapTest < Minitest::Test
  def setup
    @pq = PQBinaryHeap.new
    @pq.insert(Item.new(label: 'b', priority: 2))
    @pq.insert(Item.new(label: 'x', priority: 6))
    @pq.insert(Item.new(label: 'y', priority: 6))
    @pq.insert(Item.new(label: 'z', priority: 3))
    @pq.insert(Item.new(label: 'w', priority: 3))
    @pq.insert(Item.new(label: 'r', priority: 10))
  end

  def test_an_alias_for_insert # <<
    @pq << Item.new(label: 'm', priority: 20)
    assert_equal 'm', @pq.pull_highest.label
  end

  def test_correctly_pulls_highest_items_returning_nil_when_empty
    assert_includes ['r'],     @pq.pull_highest.label
    assert_includes ['x','y'], @pq.pull_highest.label
    assert_includes ['x','y'], @pq.pull_highest.label
    assert_includes ['z','w'], @pq.pull_highest.label
    assert_includes ['z','w'], @pq.pull_highest.label
    assert_includes ['b'],     @pq.pull_highest.label
    assert_nil    @pq.pull_highest
  end

  def test_find_highest_returns_nil_for_empty_queue
    assert_nil PQBinaryHeap.new.find_highest
  end

  def test_find_highest_returns_an_item_with_highest_priority
    assert_includes ['r'], @pq.find_highest.label
    @pq.pull_highest
    assert_includes ['x','y'], @pq.find_highest.label
  end

  def test_identifies_empty_queue
    pq = PQBinaryHeap.new
    assert pq.empty?
    pq.insert(Item.new(label:'T', priority: 5))
    refute pq.empty?
    pq.pull_highest
    assert pq.empty?
  end

  def test_clear_empties_the_priority_queue
    @pq.clear
    assert @pq.empty?
  end

  def test_returns_correct_queue_size
    assert_equal 6, @pq.size
    @pq.pull_highest
    assert_equal 5, @pq.size
  end
end
