require "spec_helper"

describe "dev" do
  %w(redis-server redis-cli tmux).each do |app|
    describe command("which #{app}") do
      its(:stdout) { should_not eq("") }
    end
  end
end