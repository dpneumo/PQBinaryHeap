require_relative 'test_helper'
require_relative '../lib/priority_queue_bh'
require_relative '../lib/item'


class PriorityQueueBHTest < Minitest::Test
  def setup
    @pq = PriorityQueueBH.new
    items = [ Item.new(label: 'A', priority: 2),
              Item.new(label: 'B', priority: 1),
              Item.new(label: 'C', priority: 4),
              Item.new(label: 'D', priority: 6),
              Item.new(label: 'E', priority: 3) ]
    items.each {|item| @pq << item }
  end

  def test_adds_item_in_correct_order
    expect = ['nil','D','C','A','B','E']
    actual = @pq.q.map {|itm| itm ? itm.label : 'nil'}
    assert_equal expect, actual
  end

  def test_removes_top_priority_item
    assert_equal 6, @pq.pull_highest.priority
    expect= ['nil','C','E','A','B']
    actual = @pq.q.map {|itm| itm ? itm.label : 'nil'}
    assert_equal expect, actual
  end

  def test_finds_highest_priority_item
    assert_equal 'D', @pq.find_highest.label
  end

  def test_can_clear_the_queue
    assert_equal [nil], @pq.clear
  end
end
