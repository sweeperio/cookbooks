require "spec_helper"

describe "base::git" do
  describe command("git --version") do
    its(:stdout) { should match(/^git version 2\.4\.4/) }
  end
end
