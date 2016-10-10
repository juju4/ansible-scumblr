require 'serverspec'

# Required by serverspec
set :backend, :exec

#describe process("sidekiq") do
#  its(:user) { should eq "_scumblr" }
#  its(:count) { should eq 1 }
#end

describe port(8000) do
  it { should be_listening.on('127.0.0.1').with('tcp') }
end

#describe process("rails") do
#  its(:user) { should eq "_scumblr" }
#  its(:count) { should eq 2 }
#end

describe port(3000) do
  it { should be_listening }
end

describe process("bundle") do
  its(:user) { should eq "_scumblr" }
#  its(:count) { should eq 1 }
  its(:args) { should match /sidekiq/ }
end
#describe process("ruby") do
#  its(:user) { should eq "_scumblr" }
#  its(:count) { should eq 2 }
#  its(:args) { should match /rails/ }
#end
describe command("ps axu") do
  its(:stdout) { should match /rails master/ }
  its(:stdout) { should match /rails worker/ }
  its(:stdout) { should match /sidekiq/ }
  its(:stdout) { should match /sketchy.celery/ }
  its(:exit_status) { should eq 0 }
end

#describe command('bash -lc "echo \"User.all\" | rails console 2>/dev/null"') do
describe command('su - _scumblr -c bash -lc "cd /var/Scumblr && echo \"User.all\" | rails console 2>/dev/null"') do
## still not soon enough. need before sudo
#  let(:pre_command) { 'cd /var/Scumblr' }
  its(:stdout) { should match /root@localhost.local/ }
  its(:stdout) { should match /user1@localhost.local/ }
#  let(:sudo_options) { '-u _scumblr -H' }
end

