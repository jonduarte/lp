# Installation

> This code was created with ruby 2.1.5

`bundle install`

# Running specs

`bundle exec rake`

# Command line interface

The command line tool: `bin/lp` will generate html files based on the inputs provided.

Usage:

```shell
bin/lp taxonomy_xml destinations_xml output_dir
```

To run the code locally:

Ex:

```shell
mkdir result
ruby bin/lp spec/fixtures/taxonomy.xml spec/fixtures/destinations.xml result/
```
