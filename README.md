# SvgOptimizer

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
# it will override the original file
SvgOptimizer.optimize("file.svg")

# it save a copy to optimized/file.svg
SvgOptimizer.optimize("file.svg", "optimized/file.svg")
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
