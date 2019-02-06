# encoding: UTF-8
#
# Copyright (c) 2010-2017 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require_relative '../shared'
require_relative '../../commands/api'

module GoodData
  module CLI
    desc ''
    command :api do |c|
      c.desc ''
      c.command :get do |store|
        store.action do |global_options, options, args|
          opts = options.merge(global_options)
          GoodData::Command::Api.get(args.first, opts)
        end
      end
    end
  end
end
