# SvgOptimizer

[![Tests](https://github.com/fnando/svg_optimizer/workflows/ruby-tests/badge.svg)](https://github.com/fnando/svg_optimizer)
[![Code Climate](https://codeclimate.com/github/fnando/svg_optimizer/badges/gpa.svg)](https://codeclimate.com/github/fnando/svg_optimizer)
[![Gem](https://img.shields.io/gem/v/svg_optimizer.svg)](https://rubygems.org/gems/svg_optimizer)
[![Gem](https://img.shields.io/gem/dt/svg_optimizer.svg)](https://rubygems.org/gems/svg_optimizer)

Some small optimizations for SVG files.

## Installation

```bash
gem install svg_optimizer
```

Or add the following line to your project's Gemfile:

```ruby
gem "svg_optimizer"
```

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

The default list of plugins is stored at `SvgOptimizer::DEFAULT_PLUGINS`. To use
your new plugin, just do something like this:

```ruby
SvgOptimizer.optimize(xml, SvgOptimizer::DEFAULT_PLUGINS + [MyPlugin])
```

## Maintainer

- [Nando Vieira](https://github.com/fnando)

## Contributors

- https://github.com/fnando/svg_optimizer/contributors

## Contributing

For more details about how to contribute, please read
https://github.com/fnando/svg_optimizer/blob/main/CONTRIBUTING.md.

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT). A copy of the license can be
found at https://github.com/fnando/svg_optimizer/blob/main/LICENSE.md.

## Code of Conduct

Everyone interacting in the svg_optimizer project's codebases, issue trackers,
chat rooms and mailing lists is expected to follow the
[code of conduct](https://github.com/fnando/svg_optimizer/blob/main/CODE_OF_CONDUCT.md).
