require 'spec_helper'

RSpec.describe Parser do
  context 'Page' do
    let(:taxonomy)     { Parser.taxonomy(File.join(File.dirname(__FILE__), 'fixtures', 'taxonomy.xml')) }
    let(:destinations) { Parser.destinations(File.join(File.dirname(__FILE__), 'fixtures', 'destinations.xml')) }
    let(:top_node) { taxonomy.nodes.first }
    let(:top_destination) { destinations.destinations.first }

    let(:html) { Builder::Page.new(top_node, top_destination).render }

    it 'renders html' do
      expect(html).to include("<h1>Lonely Planet: Africa</h1>")
    end

    it 'renders navigation' do
      expect(html).to include('<a href="355611.html">South Africa</a>')
    end
  end
end
