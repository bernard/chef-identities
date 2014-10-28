require 'spec_helper'

['/home/jsmith', '/var/tmp', '/home/test'].each do |home|
  describe file(home) do
    it { should_not be_directory }
  end
end
