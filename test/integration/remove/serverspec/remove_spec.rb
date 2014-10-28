require 'spec_helper'

describe 'user' do
  %w(test jdoe jsmith).each do |user|
    it "Doesn't have a user '#{user}'" do
      expect(user user).to_not exist
    end
  end
end
