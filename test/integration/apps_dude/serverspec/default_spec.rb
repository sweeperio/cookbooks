require "spec_helper"

describe "dude" do
  describe command("which redis") do
    its(:stdout) { should_not be_nil }
  end
end
