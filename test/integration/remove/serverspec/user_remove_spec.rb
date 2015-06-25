require 'spec_helper'

describe 'Removing an existing user' do
  describe user('user') do
    it { should_not exist }
  end
end
