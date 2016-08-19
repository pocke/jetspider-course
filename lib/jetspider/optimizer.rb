require 'jetspider/ast'
require 'jetspider/exception'

module JetSpider
  module Optimizer
    module_function

    # XXX: (1 + 2) + (3 + 4)
    # @param n [RKelly::Nodes::AddNode]
    def optimize_AddNode(n)
      return n unless n.is_a? RKelly::Nodes::AddNode

      n = RKelly::Nodes::AddNode.new(
        optimize_AddNode(n.left),
        optimize_AddNode(n.value),
      )

      if n.left.is_a?(RKelly::Nodes::NumberNode) && n.value.is_a?(RKelly::Nodes::NumberNode)
        value = n.left.value + n.value.value
        return RKelly::Nodes::NumberNode.new(value)
      end

      return n
    end
  end
end
