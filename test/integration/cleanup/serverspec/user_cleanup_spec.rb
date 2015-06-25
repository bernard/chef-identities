require 'spec_helper'

context 'clean up user' do
  describe file('/home/user') do
    it { should_not be_directory }
  end

  describe file('/var/spool/cron/user') do
    it { should_not be_file }
  end
end
