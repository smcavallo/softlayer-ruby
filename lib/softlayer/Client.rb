#
# Copyright (c) 2014 SoftLayer Technologies, Inc. All rights reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#

module SoftLayer
  # Initialize an instance of the Client class. You pass in the service name
  # and optionally hash arguments specifying how the client should access the
  # SoftLayer API.
  #
  # The following symbols can be used as hash arguments to pass options to the constructor:
  # - +:username+ - a non-empty string providing the username to use for requests to the service
  # - +:api_key+ - a non-empty string providing the api key to use for requests to the service
  # - +:endpoint_url+ - a non-empty string providing the endpoint URL to use for requests to the service
  #
  # If any of the options above are missing then the constructor will try to use the corresponding
  # global variable declared in the SoftLayer Module:
  # - +$SL_API_USERNAME+
  # - +$SL_API_KEY+
  # - +$SL_API_BASE_URL+
  #
  class Client
    # A username passed as authentication for each request. Cannot be emtpy or nil.
    attr_reader :username

    # An API key passed as part of the authentication of each request. Cannot be emtpy or nil.
    attr_reader :api_key

    # The base URL for requests that are passed to the server. Cannot be emtpy or nil.
    attr_reader :endpoint_url

    # A string passsed as the value for the User-Agent header when requests are sent to SoftLayer API.
    attr_accessor :user_agent

    def initialize(options = {})
      @services = { }

      settings = Config.client_settings(options)

      # pick up the username from the options, the global, or assume no username
      @username = settings[:username] || ""

      # do a similar thing for the api key
      @api_key = settings[:api_key] || ""

      # and the endpoint url
      @endpoint_url = settings[:endpoint_url] || API_PUBLIC_ENDPOINT

      @user_agent = settings[:user_agent] || "softlayer_api gem/#{SoftLayer::VERSION} (Ruby #{RUBY_PLATFORM}/#{RUBY_VERSION})"

      raise "A SoftLayer Client requires a username" if !@username || @username.empty?
      raise "A SoftLayer Client requires an api_key" if !@api_key || @api_key.empty?
      raise "A SoftLayer Clietn requires an enpoint URL" if !@endpoint_url || @endpoint_url.empty?
    end

    # return a hash of the authentication headers for the client
    def authentication_headers
      {
        "authenticate" => {
          "username" => @username,
          "apiKey" => @api_key
        }
      }
    end

    # Returns a service with the given name.
    #
    # If a service has already been created by this client that same service
    # will be returned each time it is called for by name. Otherwise the system
    # will try to construct a new service object and return that.
    #
    #
    # If the service has to be created then the service_options will be passed
    # along to the creative function. However, when returning a previously created
    # Service, the service_options will be ignored.
    #
    # If the service_name provided does not start with 'SoftLayer__' that prefix
    # will be added
    def service_named(service_name, service_options = {})
      raise ArgumentError,"Please provide a service name" if service_name.nil? || service_name.empty?

      # strip whitespace from service_name and
      # ensure that it start with "SoftLayer_".
      #
      # if it does not, then add it
      service_name.strip!
      if not service_name =~ /\ASoftLayer_/
        service_name = "SoftLayer_#{service_name}"
      end

      # if we've already created this service, just return it
      # otherwise create a new service
      service_key = service_name.to_sym
      if !@services.has_key?(service_key)
        @services[service_key] = SoftLayer::Service.new(service_name, {:client => self}.merge(service_options))
      end

      @services[service_key]
    end

    def [](service_name)
      service_named(service_name)
    end
  end
end
