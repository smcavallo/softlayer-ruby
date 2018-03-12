#--
# Copyright (c) 2014 SoftLayer Technologies, Inc. All rights reserved.
#
# For licensing information see the LICENSE.md file in the project root.
#++

# requirements from the core libraries
require 'date'
require 'time'

# Requirements for the Foundation Layer
require 'softlayer/base'
require 'softlayer/object_mask_helpers'
require 'softlayer/APIParameterFilter'
require 'softlayer/ObjectFilter'
require 'softlayer/ObjectMaskParser'
require 'softlayer/Config'
require 'softlayer/Client'
require 'softlayer/Service'

# Requirements for the Model Layer
require 'softlayer/ModelBase'
require 'softlayer/Datacenter'
require 'softlayer/DynamicAttribute'
require 'softlayer/Account'
require 'softlayer/AccountPassword'
require 'softlayer/NetworkMonitor'
require 'softlayer/Server'
require 'softlayer/BareMetalServer'
require 'softlayer/BareMetalServerOrder'
require 'softlayer/BareMetalServerOrder_Package'
require 'softlayer/ImageTemplate'
require 'softlayer/NetworkComponent'
require 'softlayer/NetworkMessageDelivery'
require 'softlayer/NetworkService'
require 'softlayer/NetworkStorageAllowedHost'
require 'softlayer/NetworkStorageCredential'
require 'softlayer/NetworkStorageGroup'
require 'softlayer/NetworkStorage'
require 'softlayer/ProductPackage'
require 'softlayer/ProductItemCategory'
require 'softlayer/ServerFirewall'
require 'softlayer/ServerFirewallOrder'
require 'softlayer/SoftwarePassword'
require 'softlayer/Software'
require 'softlayer/Tag'
require 'softlayer/Ticket'
require 'softlayer/UserCustomerExternalBinding'
require 'softlayer/UserCustomer'
require 'softlayer/VirtualDiskImage'
require 'softlayer/VirtualDiskImageSoftware'
require 'softlayer/VirtualServer'
require 'softlayer/VirtualServerOrder'
require 'softlayer/VirtualServerOrder_Package'
require 'softlayer/VirtualServerUpgradeOrder'
require 'softlayer/VLANFirewall'
require 'softlayer/VLANFirewallOrder'
