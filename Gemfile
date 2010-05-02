source :gemcutter

def darwin?
  require 'rbconfig'
  RbConfig::CONFIG['host_os'] =~ /darwin/i
end


group 'test' do
  gem 'autotest'
  gem 'diff-lcs'
  gem 'rack'
  gem 'rspec'

  if darwin?
    gem 'autotest-fsevent', :require => 'autotest/fsevent'
    gem 'autotest-growl', :require => 'autotest/growl'
  end
end
