# encoding: UTF-8
#
# Copyright (c) 2010-2017 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require 'gooddata/lcm/lcm2'

describe 'GoodData::LCM2' do
  describe '#skip_actions' do
    let(:client) { double(:client) }
    let(:domain) { 'domain' }
    let(:logger) { GoodData.logger }
    let(:params) do
      params = {
        skip_actions: %w(CollectSegments SynchronizeUsers),
        GDC_GD_CLIENT: client,
        GDC_LOGGER: logger,
        domain: domain
      }
      GoodData::LCM2.convert_to_smart_hash(params)
    end

    before do
      allow(client).to receive(:class) { GoodData::Rest::Client }
      allow(client).to receive(:domain) { domain }
      allow(logger).to receive(:info)
      allow(domain).to receive(:data_products)
    end

    it 'skips actions in skip_actions' do
      expect(GoodData::LCM2::CollectSegments).not_to receive(:call)
      expect(GoodData::LCM2::SynchronizeUsers).not_to receive(:call)
      GoodData::LCM2.perform('users', params)
    end
  end

  describe '#convert_to_smart_hash' do
    subject do
      GoodData::LCM2.convert_to_smart_hash(hash)
    end

    context 'when created hash contains key in upper-case' do
      let(:hash) { { FOO: 'bar' } }
      it 'fetches value of uppre-case key' do
        expect(subject.FOO).to eq('bar')
        expect(subject.foo).to eq('bar')
        expect(subject['FOO']).to eq('bar')
        expect(subject['foo']).to eq('bar')
        expect(subject[:FOO]).to eq('bar')
        expect(subject[:foo]).to eq('bar')
      end
    end
  end
end
