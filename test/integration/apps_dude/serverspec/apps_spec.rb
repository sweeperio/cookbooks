require "spec_helper"

describe "apps" do
  describe command("ls -al /opt/ejson/keys | wc -l") do
    its(:stdout) { should contain("1\n") }
  end
end
