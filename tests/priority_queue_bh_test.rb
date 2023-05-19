# frozen_string_literal: true
require_relative 'test_helper'
require_relative '../lib/priority_queue_bh'
require_relative '../lib/item'

class PriorityQueueBHTest < Minitest::Test
  def setup
    @pq = PriorityQueueBH.new
    @pq.insert(Item.new(label: 'b', priority: 2))
    @pq.insert(Item.new(label: 'x', priority: 6))
    @pq.insert(Item.new(label: 'y', priority: 6))
    @pq.insert(Item.new(label: 'z', priority: 3))
    @pq.insert(Item.new(label: 'w', priority: 3))
    @pq.insert(Item.new(label: 'r', priority: 10))
  end

  def test_empty_returns_true_when_there_are_no_items_in_the_queue
    assert PriorityQueueBH.new.empty?
  end

  def test_empty_returns_false_when_the_queue_contains_items
    refute @pq.empty?
  end

  def test_correctly_pulls_highest_items_returning_nil_when_empty
    assert_includes ['r'],     @pq.pull_highest.label
    assert_includes ['x','y'], @pq.pull_highest.label
    assert_includes ['x','y'], @pq.pull_highest.label
    assert_includes ['z','w'], @pq.pull_highest.label
    assert_includes ['z','w'], @pq.pull_highest.label
    assert_includes ['b'],     @pq.pull_highest.label
    assert_nil    @pq.pull_highest
    assert @pq.empty?
  end

  def test_find_highest_returns_an_item_with_highest_priority
    assert_includes ['r'], @pq.find_highest.label
  end

  def test_find_highest_returns_nil_for_empty_queue
    assert_nil PriorityQueueBH.new.find_highest
  end

  def test_clear_empties_the_priority_queue
    @pq.clear
    assert @pq.empty?
  end
end
