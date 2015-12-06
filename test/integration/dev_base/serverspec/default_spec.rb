require "spec_helper"

describe "dev" do
  %w(memcached redis-server redis-cli tmux fasd).each do |app|
    describe command("which #{app}") do
      its(:stdout) { should_not eq("") }
    end
  end

  %w(node coffee grunt).each do |app|
    describe command("which #{app}") do
      its(:stdout) { should_not eq("") }
    end
  end
end
