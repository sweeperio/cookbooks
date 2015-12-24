require "spec_helper"

describe "base[role]" do
  USERS = %w(pseudomuto).freeze

  context "users" do
    USERS.each do |user|
      describe user(user) do
        it { should exist }
        it { should belong_to_group(user) }
      end
    end
  end
end
