require "spec_helper"

describe "users" do
  %w(pseudomuto deploy).each do |user_account|
    describe user(user_account) do
      it { should exist }
      it { should belong_to_group(user_account) }
    end
  end
end
