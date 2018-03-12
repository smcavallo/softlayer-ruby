#--
# Copyright (c) 2018 SoftLayer Technologies, Inc. All rights reserved.
#
# For licensing information see the LICENSE.md file in the project root.
#++

module SoftLayer
  # http://sldn.softlayer.com/reference/services/SoftLayer_Tag
  class Tag < SoftLayer::ModelBase
    include ::SoftLayer::DynamicAttribute

    # Create a new order that works through the given client connection
    def initialize (client = nil)
      @softlayer_client = client || Client.default_client
      raise "#{__method__} requires a client but none was given and Client::default_client is not set" if !@softlayer_client
    end

    ##
    # Adds a tag to a softlayer object
    # http://sldn.softlayer.com/reference/services/SoftLayer_Tag/setTags
    #
    # The options parameter should contain:
    #
    # <b>+:client+</b> - The client used to connect to the API
    #
    # If no client is given, then the routine will try to use Client.default_client
    # If no client can be found the routine will raise an error.
    #
    # You may filter the list returned by adding options:
    # * <b>+:tags+</b>            (string/array) - An array of strings (tags) to add to the object
    # * <b>+:keyName+</b>         (string)       - key name of a tag type, Ex. GUEST, HARDWARE
    # * <b>+:resourceTableId+</b> (string/array) - ID of the object being tagged
    #
    def self.setTags(tags, keyName, resourceTableId, options = {})
      softlayer_client = options[:client] || Client.default_client
      raise "#{__method__} requires a client but none was given and Client::default_client is not set" if !softlayer_client

      # Validate inputs
      raise ArgumentError, 'tags must be set' unless tags
      raise ArgumentError, 'At least one tag is required' unless tags.any?
      raise ArgumentError, 'keyName must be set' unless keyName
      raise ArgumentError, 'resourceTableId must be set' unless resourceTableId

      # Parameter format
      parameters = {parameters: [
          tags * ",",
          keyName,
          resourceTableId
      ]
      }

      softlayer_client[:Tag].setTags(parameters)
    end

  end # class Tag
end # module SoftLayer
