require 'spec_helper'

context 'manage action' do
  context 'user: user' do
    describe user('user') do
      it { should exist }
      it { should belong_to_group 'user' }
      it { should have_home_directory '/home/user' }
      it { should have_login_shell '/bin/bash' }
    end

    describe file('/home/user') do
      it { should be_directory }
      it { should be_mode 700 }
      it { should be_owned_by 'user' }
      it { should be_grouped_into 'user' }
    end
  end

  context 'user: user2' do
    describe user('user2') do
      it { should have_home_directory '/opt/user2' }
    end

    describe file('/opt/user2') do
      it { should be_directory }
      it { should be_mode 700 }
      it { should be_owned_by 'user2' }
      it { should be_grouped_into 'user2' }
    end
  end

  context 'user: root' do
    describe user('root') do
      it { should have_home_directory '/root' }
    end
  end

  context 'user: user3' do
    describe user('user3') do
      it 'should have uid less than 1000' do
        expect(`id user3 | awk '{ print $1 }' | cut -f2 -d'=' | cut -f1 -d'('`.to_i).to be < 1000
      end
    end
  end

  context 'user: user4' do
    describe user('user4') do
      it { should have_uid 10000 }

      it 'should have gid 10000' do
        expect(`id user4 | awk '{ print $2 }' | cut -f2 -d'=' | cut -f1 -d'('`.to_i).to be == 10000
      end
    end
  end

  context 'user: user5' do
    describe user('user5') do
      it { should have_login_shell '/sbin/nologin' }
    end
  end

  context 'user: user6' do
    describe user('user6') do
      it 'should have password' do
        expect(`grep user6 /etc/shadow | cut -f2 -d':'`).not_to match(/^!!$/)
      end
    end
  end

  context 'user: user7' do
    describe user('user7') do
      it { should have_uid 30000 }
    end
  end
end
