# encoding: UTF-8
#
# Copyright (c) 2010-2017 GoodData Corporation. All rights reserved.
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.

require 'gooddata/lcm/actions/collect_dynamic_schedule_params'
require 'gooddata/lcm/lcm2'

describe GoodData::LCM2::CollectDymanicScheduleParams do
  let(:data_source) { double(:data_source) }
  subject { GoodData::LCM2.run_action(GoodData::LCM2::CollectDymanicScheduleParams, params) }

  before do
    allow(GoodData::Helpers::DataSource).to receive(:new).and_return(data_source)
    allow(data_source).to receive(:realize).and_return('spec/data/dynamic_schedule_params_table.csv')
  end

  let(:params) do
    params = {
      dynamic_params: {
        input_source: {}
      }
    }
    GoodData::LCM2.convert_to_smart_hash(params)
  end

  context 'when dynamic schedule params are passed' do
    it 'collects them' do
      expected = {
        'client_1' => {
          'rollout' => {
            'MODE' => {
              'value' => 'mode_a',
              'hidden' => false
            }
          },
          all_schedules: {
            'MODE' => {
              'value' => 'mode_x',
              'hidden' => false
            }
          },
          'release' => {
            'MODE' => {
              'value' => 'mode_c',
              'hidden' => false
            }
          }
        },
        'client_2' => {
          'provisioning' => {
            'MODE' => {
              'value' => 'mode_b',
              'hidden' => false
            }
          }
        },
        all_clients: {
          all_schedules: {
            'MODE' => {
              'value' => 'mode_all',
              'hidden' => false
            }
          }
        }
      }
      expect(subject[:params][:schedule_params]).to eq(expected)
    end
  end

  context 'when input contains hidden parameter' do
    before do
      allow(data_source).to receive(:realize).and_return('spec/data/dynamic_schedule_hidden_params_table.csv')
    end

    let(:expected) do
      {
        'client_1' => {
          'my_schedule' => {
            'big_secret' => {
              'value' => 'melon_is_vegetable',
              'hidden' => true
            }
          }
        }
      }
    end

    it 'sets hidden to true' do
      expect(subject[:params][:schedule_params]).to eq(expected)
    end
  end
end
