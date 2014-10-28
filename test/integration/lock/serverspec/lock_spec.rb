require 'spec_helper'

%w(test jdoe jsmith).each do |user|
  if os[:family] == 'ubuntu'
    cmd = "passwd -S #{user} | awk '{ print $2 }' | grep L"
  else
    cmd = "passwd -S #{user} | awk '{ print $2 }' | grep LK"
  end

  describe command(cmd) do
    its(:exit_status) { should eq 0 }
  end
end
