require 'sax-machine'

module Parser
  def self.taxonomy(file)
    Taxonomy.parse(File.read(file))
  end

  def self.destinations(file)
    Destinations.parse(File.read(file))
  end

  class Node
    include SAXMachine

    element :node_name, as: :title
    element :atlas_node_id, as: :atlas_id
    elements :node, as: :nodes, class: Node

    ancestor :node

    attribute :atlas_node_id do |atlas_id|
      atlas_id.to_i
    end

    def parent
      node if node.class == Node
    end

    def while_parent(&block)
      return unless parent
      parent.while_parent(&block)
      yield parent
    end

    def traverse(&block)
      block.call(self)
      nodes.each do |node|
        node.traverse(&block)
      end
    end
  end

  class Taxonomy
    include SAXMachine

    elements :node, as: :nodes, class: Node

    def traverse(&block)
      nodes.each do |node|
        node.traverse(&block)
      end
    end
  end

  class Destination
    include SAXMachine

    element :history
    element :overview
    element :money_and_costs

    attribute :atlas_id do |atlas_id|
      atlas_id.to_i
    end
  end

  class Destinations
    include SAXMachine

    elements :destination, :as => :destinations, :class => Destination

    def find_by_atlas_id(atlas_id)
      destinations.find { |destination| destination.atlas_id == atlas_id }
    end
  end
end
