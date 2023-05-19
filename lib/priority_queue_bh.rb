# frozen_string_literal: true
class PriorityQueueBH
  # Based on a binary heap
  # Does NOT guarantee members of the queue are unique
  # Does NOT guarantee FIFO order of retreived members with same priority
  # insert: O(log #members), find_highest: O(1), pull_highest: O(log #members)
  attr_reader :q
  def initialize
    @q = [nil]
  end

  def insert(item)
    @q << item
    bubble_up(max_index)
  end
  alias_method :<<, :insert

  def pull_highest
    exchange(1, max_index)
    @q.pop.tap {|_| bubble_down(1) }
  end

  def find_highest
    @q[1]
  end

  def empty?
    @q.compact.empty?
  end

  def clear
    @q = [nil]
  end

  private
  def max_index
    @q.size - 1
  end

  def bubble_up(index)
    parent_index = (index / 2)
    return if index <= 1
    return if @q[parent_index] >= @q[index]
    exchange(index, parent_index)
    bubble_up(parent_index)
  end

  def bubble_down(index)
    child_index = (index * 2)
    return if child_index > max_index
    child_index = highest_priority_child_ndx(child_index)
    return if @q[index] >= @q[child_index]
    exchange(index, child_index)
    bubble_down(child_index)
  end

  def highest_priority_child_ndx(child_index)
    return child_index if child_index == max_index
    @q[child_index + 1] > @q[child_index] ? child_index + 1 : child_index
  end

  def exchange(source, target)
    @q[source], @q[target] = @q[target], @q[source]
  end
end
