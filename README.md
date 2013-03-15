# InfiniteTime

[![Build Status](https://secure.travis-ci.org/amarshall/infinite_time.png?branch=master)](http://travis-ci.org/amarshall/infinite_time)

Provides a representation of a (positively or negatively) infinite time. This allows easier comparison with times when, for instance, you have an end date for an object but it is not yet known. Using `nil` would cause TypeErrors everywhere and you must then guard against that, this avoids that issue.

Many judgement calls were made in how to best reimplement methods that exist on Time but don’t really make sense on an infinite time. Comments and suggestions on how the behavior of any method on InfiniteTime could be improved is welcome. Open an issue or submit a pull request.

## Installation

Install as usual: `gem install infinite_time` or add `gem 'infinite_time'` to your Gemfile. Note that Ruby 2.0 is required.

## Usage

Simply create a new positive or negative infinite time:

```ruby
positive = InfiniteTime.new :+
negative = InfiniteTime.new :-

positive == InfiniteTime.new  #=> true
```

Feel free to read the specs for more details.

## Contributing

Contributions are welcome. Please be sure that your pull requests are atomic so they can be considered and accepted separately.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits & License

Copyright © 2013 J. Andrew Marshall. License is available in the LICENSE file.
