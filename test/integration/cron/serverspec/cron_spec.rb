#
# Author:: Noah Kantrowitz <noah@coderanger.net>
#
# Copyright 2014, Balanced, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'serverspec'
include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

ENV['RDECK_BASE'] = '/var/lib/rundeck'

describe command('rd-jobs -p fabric --name one --file /dev/stdout --format yaml') do
  it { should return_exit_status(0) }
  its(:stdout) { should include('description: Task one.') }
  its(:stdout) { should include('time:') }
  its(:stdout) { should include("minute: '0'") }
  its(:stdout) { should include("hour: '12'") }
end

describe command('rd-jobs -p fabric --name two --file /dev/stdout --format yaml') do
  it { should return_exit_status(0) }
  its(:stdout) { should include("description: |-\n    Task\n        two.") }
  its(:stdout) { should include('time:') }
  its(:stdout) { should include("minute: '45'") }
  its(:stdout) { should include("hour: '0'") }
end

describe command('rd-jobs -p fabric --name three --file /dev/stdout --format yaml') do
  it { should return_exit_status(0) }
  its(:stdout) { should include('description: Take three.') }
end
