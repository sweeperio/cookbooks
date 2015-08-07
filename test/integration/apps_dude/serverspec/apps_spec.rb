require "spec_helper"

describe "apps" do
  describe file("/opt/ejson/keys") do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by("deploy") }
    it { should be_grouped_into("deploy") }
    it { should be_mode("0660") }
  end

  describe command("ls -al /opt/ejson/keys | wc -l") do
    its(:stdout) { should contain("1\n") }
  end

  describe file("/var/code") do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by("deploy") }
    it { should be_grouped_into("deploy") }
    it { should be_mode("0770") }
  end

  describe file("/var/code/.ssh/dude_deploy_key") do
    it { should exist }
    it { should be_owned_by("deploy") }
    it { should be_grouped_into("deploy") }
    it { should be_mode("0640") }
  end

  describe file("/var/code/.ssh/dude_deploy_key.pub") do
    it { should exist }
    it { should be_owned_by("deploy") }
    it { should be_grouped_into("deploy") }
    it { should be_mode("0640") }
end
