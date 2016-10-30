require 'serverspec'

# Required by serverspec
set :backend, :exec

describe package('nginx'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('nginx'), :if => os[:family] == 'ubuntu' do
  it { should be_installed }
end

describe service('nginx'), :if => os[:family] == 'redhat' do
  it { should be_enabled }
  it { should be_running }
end

describe service('nginx'), :if => os[:family] == 'ubuntu' do
  it { should be_enabled }
  it { should be_running }
end

describe service('org.nginx.httpd'), :if => os[:family] == 'darwin' do
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end

#describe port(443) do
#  it { should be_listening }
#end


