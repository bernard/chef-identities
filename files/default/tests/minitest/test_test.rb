require 'minitest/spec'

describe_recipe 'identities::test' do
  describe 'users' do
    it 'makes sure the test user is created' do
      user('test').must_exist.with(:home, '/tmp/test', 0755)
    end

    it 'makes sure the test user is created' do
      user('root').must_exist.with(:home, '/root', 0700)
    end

    it 'makes sure the test user is created' do
      user('jdoe').must_exist.with(:home, '/var/tmp', 0755)
    end

    it 'makes sure the test user is created' do
      user('jsmith').must_exist.with(:home, '/home/jsmith', 0755)
    end
  end

  describe 'dirs' do
    it 'makes sures the home dir is created' do
      directory('/tmp/test').must_exist.with(:owner, 'test').with(:group, 'root').with(:mode, 0755)
    end

    it 'makes sures the home dir is created' do
      directory('/root').must_exist.with(:owner, 'root').with(:group, 'root').with(:mode, 0700)
    end

    it 'makes sures the home dir is created' do
      directory('/var/tmp').must_exist.with(:owner, 'jdoe').with(:group, 'root').with(:mode, 0755)
    end

    it 'makes sures the home dir is created' do
      directory('/home/jsmith').must_exist.with(:owner, 'jsmith').with(:group, 'root').with(:mode, 0755)
    end
  end
end
