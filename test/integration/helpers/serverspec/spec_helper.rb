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
      it "Has a user named '#{user}'" do
        expect(user user).to exist
        if user == 'jsmith'
          expect(user user).to have_login_shell '/sbin/nologin'
        end
      end

      it "User '#{user}' has home directory '#{home}'" do
        expect(file home).to be_directory
        if user == 'jsmith'
          expect(file home).to be_mode 755
        else
          expect(file home).to be_mode 700
        end
      end

      it "Has a SSH directory '#{home}/.ssh'" do
        expect(file "#{home}/.ssh").to be_directory
        expect(file "#{home}/.ssh").to be_mode 700
      end

      if user == 'root'
        it "Has an authorized_keys file '#{home}/.ssh/authorized_keys'" do
          expect(file "#{home}/.ssh/authorized_keys").to be_file
          expect(file "#{home}/.ssh/authorized_keys").to be_mode 644
          expect(file "#{home}/.ssh/authorized_keys").to contain 'somesupersecretkey'
        end

        it "Has an id_rsa.pub file '#{home}/.ssh/id_rsa.pub'" do
          expect(file "#{home}/.ssh/id_rsa.pub").to be_file
          expect(file "#{home}/.ssh/id_rsa.pub").to be_mode 644
          expect(file "#{home}/.ssh/id_rsa.pub").to contain 'sshpubkey'
        end

        it "Has an id_rsa file '#{home}/.ssh/id_rsa'" do
          expect(file "#{home}/.ssh/id_rsa").to be_file
          expect(file "#{home}/.ssh/id_rsa").to be_mode 400
          expect(file "#{home}/.ssh/id_rsa").to contain 'sshprivkey'
        end
      end
    end
  end
end
