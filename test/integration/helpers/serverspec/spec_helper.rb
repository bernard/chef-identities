require 'serverspec'

set :backend, :exec

shared_examples_for 'core' do
  describe 'group' do
    describe group('operators') do
      it { should exist }
      it { should have_gid 20000 }
    end

    %w(jsmith jdoe).each do |user|
      describe user(user) do
        it { should belong_to_group 'operators' }
      end
    end

    describe group('testers') do
      it { should exist }
    end

    %w(root joebob jsmith jdoe).each do |user|
      describe user(user) do
        it { should belong_to_group 'testers' }
      end
    end
  end

  describe 'user' do
    users = {
      'root' => '/root',
      'test' => '/home/test',
      'jdoe' => '/var/tmp',
      'jsmith' => '/home/jsmith'
    }

    users.each do |user, home|
      describe user(user) do
        it { should exist }
        it { should have_home_directory home }
        it { should have_login_shell '/sbin/nologin' } if user == 'jsmith'
        it { should have_uid 10000 } if user == 'jsmith'
        it { should belong_to_group 'root' } if user == 'jsmith'
      end

      describe file(home) do
        it { should be_directory }
        if user == 'jsmith'
          it { should be_mode 755 }
        else
          it { should be_mode 700 }
        end
      end

      describe file("#{home}/.ssh") do
        it { should be_directory }
        it { should be_mode 700 }
      end

      if user == 'root'
        files = {
          "#{home}/.ssh/authorized_keys" => { 'mode' => 644, 'string' => 'somesupersecretkey' },
          "#{home}/.ssh/id_rsa.pub" => { 'mode' => 644, 'string' => 'sshpubkey' },
          "#{home}/.ssh/id_rsa" => { 'mode' => 400, 'string' => 'sshprivkey' }
        }
        files.each do |file|
          describe file(file[0]) do
            it { should be_file }
            it { should be_mode file[1]['mode'] }
            it { should contain file[1]['string'] }
          end
        end
      end
    end
  end
end
