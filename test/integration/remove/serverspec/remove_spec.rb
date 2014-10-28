require 'spec_helper'

describe 'user' do
  %w(test jdoe jsmith).each do |user|
    describe user(user) do
      it { should_not exist }
    end
  end
end
