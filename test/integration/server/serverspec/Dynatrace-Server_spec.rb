require 'serverspec'

# Required by serverspec
set :backend, :exec

describe user('dynatrace') do
  it { should exist }
  it { should belong_to_group 'dynatrace' }
end

describe file('/opt/dynatrace') do
  it { should be_directory }
  it { should be_symlink }
  it { should be_mode 777 }
  it { should be_owned_by 'dynatrace' }
  it { should be_grouped_into 'dynatrace' }
end

describe file('/opt/dynatrace/agent') do
  it { should be_directory }
  it { should be_owned_by 'dynatrace' }
  it { should be_grouped_into 'dynatrace' }
end

describe file ('/opt/dynatrace/agent/conf/dtwsagent.ini') do
  its(:content) { should match /Name .+/ }
  its(:content) { should match /Server .+/ }
end

describe service('dynaTraceCollector') do
  it { should be_enabled }
  it { should be_running }

  if os[:family] == 'debian' || os[:family] == 'ubuntu'
      it { should be_enabled.with_level(3) }
      it { should be_enabled.with_level(4) }
      it { should be_enabled.with_level(5) }
  end
end

describe service('dynaTraceServer') do
  it { should be_enabled }
  it { should be_running }

  if os[:family] == 'debian' || os[:family] == 'ubuntu'
      it { should be_enabled.with_level(3) }
      it { should be_enabled.with_level(4) }
      it { should be_enabled.with_level(5) }
  end
end

describe service('dynaTraceWebServerAgent') do
  it { should be_enabled }
  it { should be_running }

  if os[:family] == 'debian' || os[:family] == 'ubuntu'
      it { should be_enabled.with_level(3) }
      it { should be_enabled.with_level(4) }
      it { should be_enabled.with_level(5) }
  end
end

describe port(2021) do
  it { should be_listening }
end

describe port(6698) do
  it { should be_listening }
end

describe port(6699) do
  it { should be_listening }
end

describe port(8020) do
  it { should be_listening }
end

describe port(8021) do
  it { should be_listening }
end

describe port(9998) do
  it { should be_listening }
end
