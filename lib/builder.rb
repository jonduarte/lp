require 'erb'
require_relative './parser'

module Builder
  TEMPLATE_DIR = './template'
  TEMPLATE     = 'destination.html.erb'

  class Prepare
    def self.create_pages(taxonomy_xml, destinations_xml, output_dir)
      taxonomy = Parser.taxonomy(taxonomy_xml)
      destinations = Parser.destinations(destinations_xml)

      Prepare.new(taxonomy, destinations, output_dir).run
    end

    attr_reader :output_dir, :taxonomy, :destinations

    def initialize(taxonomy, destinations, output_dir)
      @output_dir = output_dir
      @taxonomy = taxonomy
      @destinations = destinations
    end

    def copy_css
      dest = File.join(output_dir, 'static')
      src  = File.join(TEMPLATE_DIR, 'static')

      FileUtils.copy_entry src, dest
    end

    def run
      copy_css
      @taxonomy.traverse do |node|
        destination = destinations.find_by_atlas_id(node.atlas_node_id)
        Page.new(node, destination).save(output_path(node))
      end
    end

    def output_path(node)
      fail unless node.atlas_node_id
      File.join(output_dir, "#{node.atlas_node_id}.html")
    end
  end

  class Page

    include ERB::Util

    attr_accessor :node, :destination

    def initialize(node, destination)
      @node = node
      @destination = destination
    end

    def template
      File.join(File.expand_path(TEMPLATE_DIR), TEMPLATE)
    end

    def indent(level)
      "%spx" % [level * 10]
    end

    def render
      ERB.new(File.read(template)).result(binding)
    end

    def save(file)
      File.open(file, "w+") do |f|
        f.write(render)
      end
    end
  end
end
