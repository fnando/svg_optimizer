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
```

You can specify the plugins you want to enable. The method signature is:

```ruby
SvgOptimizer.optimize(xml, plugins)
SvgOptimizer.optimize_file(input, output, plugins)
```

where `plugins` is an array of classes that implement the following contract:

```ruby
class MyPlugin < SvgOptimizer::Plugins::Base
  def process
    xml.xpath("//comment()").remove
  end
end
```

The default list of plugins is stored at `SvgOptimizer::DEFAULT_PLUGINS`. To use your new plugin, just do something like this:

```ruby
SvgOptimizer.optimize(xml, SvgOptimizer::DEFAULT_PLUGINS + [MyPlugin])
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
