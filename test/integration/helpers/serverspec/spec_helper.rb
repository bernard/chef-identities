require 'serverspec'

set :backend, :exec

shared_examples_for 'core' do
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
        it { should have_login_shell '/sbin/nologin' } if user == 'jsmith'
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
