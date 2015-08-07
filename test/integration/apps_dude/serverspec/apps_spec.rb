require "spec_helper"

describe "apps" do
  describe file("/opt/ejson/keys") do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by("deploy") }
    it { should be_grouped_into("deploy") }
    it { should be_mode(660) }
  end

  describe command("ls -1 /opt/ejson/keys | wc -l") do
    its(:stdout) { should eq("1\n") }
  end

  describe file("/home/deploy/.ssh") do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by("deploy") }
    it { should be_grouped_into("deploy") }
    it { should be_mode(700) }
  end

  describe file("/home/deploy/.ssh/dude_deploy_key") do
    it { should exist }
    it { should be_owned_by("deploy") }
    it { should be_grouped_into("deploy") }
    it { should be_mode(640) }
  end

  describe file("/home/deploy/.ssh/dude_deploy_key.pub") do
    it { should exist }
    it { should be_owned_by("deploy") }
    it { should be_grouped_into("deploy") }
    it { should be_mode(640) }
  end
end
