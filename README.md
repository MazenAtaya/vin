# Vin

This is a wine club. Customers can subscriber to receive monthly deliveries of wine. They can do things like rating wines, adding private notes to their deliveries, and changing the delivery size. A delivery partner uses the software to get a list of the customers to deliver to.

## Installation

Clone the project:

    $ git clone https://github.com/mazen555/vin.git

Build the gem:

    $ cd vin
    $ bundle install
    $ gem build vin.gemspec	
    $ sudo gem install vin-0.1.0.gem

## Run the tests and show the coverage:

    $ rspec

## Run the server:

    $ cd lib/
    $ ruby vin_server.rb


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mazen555/vin.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

