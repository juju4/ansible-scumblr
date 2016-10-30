require 'serverspec'

# Required by serverspec
set :backend, :exec

#describe command('psql db-scumblr-postgresql_development -c "\dt"') do
describe command('su - postgres -c "psql db-scumblr-postgresql_development -c \"\\dt\""') do
  its(:stdout) { should match /results/}
  its(:stdout) { should match /sessions/}
  its(:exit_status) { should eq 0 }
#  let(:sudo_options) { '-u postgres -H' }
end

