class PolyTreeNode
  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  attr_accessor :value, :parent, :children

  def parent=(parent)
    if !@parent.nil? && @parent.children.include?(self)
      @parent.children.delete_if { |child| child == self }
    end

    @parent = parent

    unless parent.nil? || parent.children.include?(self)
      parent.children << self
    end
  end

  def add_child(new_child)
    @children << new_child
    new_child.parent = self
  end

  def remove_child(old_child)
    if @children.include?(old_child)
      old_child.parent = nil
      @children.delete_if { |child| child == old_child }
    else
      raise "You don't have that child"
    end
  end

  def dfs(target_value)
    return self if target_value == self.value

    if self.children.count > 0
      self.children.each do |child|
        target = child.dfs(target_value)

        return target if target.nil? == false
      end
    end

    nil
  end

  def bfs(target_value)
    queue = [self]

    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target_value
      queue += current_node.children
    end

    nil
  end

  def trace_path_back(start_node)
    path = []
    current_node = self

    until current_node == start_node
      path << current_node.value
      current_node = current_node.parent
    end

    path << current_node.value

    path.reverse
  end

end
