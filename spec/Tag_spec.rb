#--
# Copyright (c) 2018 SoftLayer Technologies, Inc. All rights reserved.
#
# For licensing information see the LICENSE.md file in the project root.
#++

$LOAD_PATH << File.expand_path(File.join(File.dirname(__FILE__), "../lib"))

require 'rubygems'
require 'softlayer_api'
require 'rspec'
require 'uri'

describe SoftLayer::Tag do
  before(:each) do
    SoftLayer::Tag.send(:public, *SoftLayer::Tag.protected_instance_methods)
    SoftLayer::Client.default_client =  SoftLayer::Client.new(:username => "fakeusername", :api_key => 'DEADBEEFBADF00D')
  end

  it "allows creation using the default client" do
    SoftLayer::Client.default_client = SoftLayer::Client.new(:username => "fakeusername", :api_key => 'DEADBEEFBADF00D')
    tag = SoftLayer::Tag.new()
    expect(tag.instance_eval { @softlayer_client }).to be(SoftLayer::Client.default_client)
    SoftLayer::Client.default_client = nil
  end

  it "raises an error if you try to create a tag with no client" do
    SoftLayer::Client.default_client = nil
    expect { SoftLayer::Tag.new() }.to raise_error(RuntimeError)
  end

  it "throws an exception if tags aren't set" do
    tags = nil
    keyName = 'keyName'
    resourceTableId = 12345
    expect { SoftLayer::Tag.setTags(tags, keyName, resourceTableId) }.to raise_error(ArgumentError, 'tags must be set')
  end

  it "throws an exception if empty tags" do
    tags = []
    keyName = 'keyName'
    resourceTableId = 12345
    expect { SoftLayer::Tag.setTags(tags, keyName, resourceTableId) }.to raise_error(ArgumentError, 'At least one tag is required')
  end

  it "throws an exception if keyName is not set" do
    tags = ['tag1', 'tag2']
    keyName = nil
    resourceTableId = 12345
    expect { SoftLayer::Tag.setTags(tags, keyName, resourceTableId) }.to raise_error(ArgumentError, 'keyName must be set')
  end

  it "throws an exception if resourceTableId is not set" do
    tags = ['tag1', 'tag2']
    keyName = 'keyName'
    resourceTableId = nil
    expect { SoftLayer::Tag.setTags(tags, keyName, resourceTableId) }.to raise_error(ArgumentError, 'resourceTableId must be set')
  end

  describe "methods returning available options for attributes" do
    let (:client) do
      client = SoftLayer::Client.new(:username => "fakeusername", :api_key => 'DEADBEEFBADF00D')
      tag_service = client[:Tag]
      allow(tag_service).to receive(:call_softlayer_api_with_params)

      fake_options = {parameters: [
          ['tag1', 'tag2'] * ",",
          'keyName',
          12345
      ]
      }
      allow(tag_service).to receive(:setTags) {
        fake_options
      }

      client
    end

    after (:each) do
      SoftLayer::Client.default_client = nil
    end

  end
end
