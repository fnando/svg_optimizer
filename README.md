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
# Optimize an existing String.
xml = File.read("file.svg")
optimized = SvgOptimizer.optimize(xml)

# Optimize a file - it will override the original file.
SvgOptimizer.optimize_file("file.svg")

# Optimize a file - it saves a copy to "optimized/file.svg".
SvgOptimizer.optimize_file("file.svg", "optimized/file.svg")
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
