require 'minitest/spec'

describe_recipe 'identities::test' do
  describe 'users' do
    it 'makes sure the test user is created' do
      user('test').must_exist.with(:home, '/home/test', 0755)
    end
  end

  describe 'dirs' do
    it 'makes sures the home dir is created' do
      directory('/home/test').must_exist.with(:owner, 'test').with(:group, 'root').with(:mode, 0755)
    end
  end
end
