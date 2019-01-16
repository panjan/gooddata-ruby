# encoding: UTF-8
#
# Copyright (c) 2010-2017 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

# GoodData Module
module GoodData
  VERSION = File.open(File.expand_path('../../SDK_VERSION', File.dirname(__FILE__))) { |f| f.readline.strip }
  BRICKS_VERSION = File.open(File.expand_path('../../VERSION', File.dirname(__FILE__))) { |f| f.readline.strip }

  class << self
    # SDK version
    # @return SDK version
    def version
      VERSION
    end

    alias_method :sdk_version, :version

    # LCM bricks version
    # @return brick version
    def bricks_version
      BRICKS_VERSION
    end

    # Identifier of gem version
    # @return Formatted gem version
    def gem_version_string
      "gooddata-gem/#{VERSION}/#{RUBY_PLATFORM}/#{RUBY_VERSION}"
    end
  end
end
