# Installation

> This code was created with ruby 2.1.5

`bundle install`

# Running specs

`bundle exec rake`

# Command line interface

The command line tool: `bin/lp` will generate html files based on the inputs provided.

Usage:

> bin/lp <TAXONOMY_XML> <DESTINATIONS_XML> <OUTPUT_DIR>

To run the code locally:

Ex:

> mkdir result
> ruby bin/lp spec/fixtures/taxonomy.xml spec/fixtures/destinations.xml result/
