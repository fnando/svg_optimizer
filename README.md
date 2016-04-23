# SvgOptimizer

[![Travis-CI](https://travis-ci.org/fnando/svg_optimizer.png)](https://travis-ci.org/fnando/svg_optimizer)
[![Code Climate](https://codeclimate.com/github/fnando/svg_optimizer/badges/gpa.svg)](https://codeclimate.com/github/fnando/svg_optimizer)
[![Test Coverage](https://codeclimate.com/github/fnando/svg_optimizer/badges/coverage.svg)](https://codeclimate.com/github/fnando/svg_optimizer/coverage)
[![Gem](https://img.shields.io/gem/v/svg_optimizer.svg)](https://rubygems.org/gems/svg_optimizer)
[![Gem](https://img.shields.io/gem/dt/svg_optimizer.svg)](https://rubygems.org/gems/svg_optimizer)

Some small optimizations for SVG files.

## Installation

Add this line to your application's Gemfile:

    gem 'svg_optimizer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install svg_optimizer

## Usage

```ruby
# Optimize an existing String.
xml = File.read("file.svg")
optimized = SvgOptimizer.optimize(xml)

# Optimize a file - it will override the original file.
SvgOptimizer.optimize_file("file.svg")

# Optimize a file - it saves a copy to "optimized/file.svg".
SvgOptimizer.optimize_file("file.svg", "optimized/file.svg")

# Optimize including only specific tweaks
# Values: :remove_comment, :remove_editor_namespace,
#         :remove_empty_attribute, :remove_empty_container,
#         :remove_empty_text_node, :remove_hidden_element, :remove_metadata,
#         :remove_raster_image, :remove_unused_namespace
optimized = SvgOptimizer.optimize(xml, with: :remove_comment)

# Optimize excluding tweaks
optimized = SvgOptimizer.optimize(xml, without: [:remove_comment, :remove_empty_attribute] )
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
