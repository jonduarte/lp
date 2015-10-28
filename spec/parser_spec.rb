require 'spec_helper'

RSpec.describe Parser do
  context 'Taxonomy' do
    let(:file) { File.join(File.expand_path(File.dirname(__FILE__)), 'fixtures', 'taxonomy.xml') }
    let(:taxonomy) { Parser.taxonomy(file) }
    let(:top_node) { taxonomy.nodes.first }

    it 'parses nodes correctly' do
      expect(top_node.title).to eq('Africa')
    end

    it 'has atlas_node_id' do
      expect(top_node.atlas_node_id).to eq(355064)
    end

    it 'has parents' do
      sub_node = taxonomy.nodes.first.nodes.first
      expect(sub_node.parent).to eq(top_node)
    end

  end

  context 'Destination' do
    let(:file) { File.join(File.expand_path(File.dirname(__FILE__)), 'fixtures', 'destinations.xml') }
    let(:destinations) { Parser.destinations(file) }
    let(:destination) { destinations.destinations.first }

    it 'parses history' do
      starts = "You’ve probably heard the claim that Africa is"
      ends   = "southern Africa, and the age of the African empires had begun."

      expect(destination.history).to match(starts)
      expect(destination.history).to match(ends)
    end

    it 'has atlas_id' do
      expect(destination.atlas_id).to eq(355064)
    end

    it 'finds destination by atlas id' do
      found = destinations.find_by_atlas_id(355064)
      expect(found).to eq(destination)
    end
  end
end
