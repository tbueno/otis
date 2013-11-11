# Otis

API Wrapper Framework

## Installation

Add this line to your application's Gemfile:

    gem 'otis'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install otis

## Usage

### Map

It all starts by describing the webservice/API that you would be interacting to by creating Otis::Map of entry points and response objects.

Using the example of [link to unzip example], this first step would be like this:

    Otis::Map.new({
 	    :get_info_by_zip => UsZip::InfoZipResponse,
      :get_info_by_state => UsZip::InfoStateResponse,
      :get_info_by_city => UsZip::InfoCityResponse,
      :get_info_by_area_code => UsZip::InfoAreaCodeResponse
    })

### Client
Otis offers a base Client class that handle the response and instantiates the response object accordingly.

    Otis::Client.new(routes, "http://www.webservicex.net/uszip.asmx?WSDL")

### Model

The Client takes care of transforming the API response into a Hash. Having hashes, makes it easy to create response objects, called Otis::Model.

The main purpose of a Otis::Model is to wrap a hash into a object with helpful methods for dealing with inconsistence and other useful functionalities.



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
