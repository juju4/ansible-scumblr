require 'serverspec'

# Required by serverspec
set :backend, :exec

describe service('postgresql') do
  it { should be_enabled   }
  it { should be_running   }
end  

describe port(5432) do
  it { should be_listening }
end

