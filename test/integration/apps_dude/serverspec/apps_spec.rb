require "spec_helper"

describe "apps" do
  describe file("/opt/ejson/keys") do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by("deploy") }
    it { should be_grouped_into("deploy") }
    it { should be_mode(550) }
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

  describe file("/home/deploy/repos/dude.sh") do
    it { should exist }
    it { should be_file }
    it { should be_owned_by("deploy") }
    it { should be_grouped_into("deploy") }
    it { should be_mode(750) }
  end

  describe file("/home/deploy/repos/dude") do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by("deploy") }
    it { should be_grouped_into("deploy") }
    it { should be_mode(755) }
  end

  describe file("/home/deploy/.ssh/dude_deploy_key") do
    it { should exist }
    it { should be_owned_by("deploy") }
    it { should be_grouped_into("deploy") }
    it { should be_mode(600) }
  end

  describe file("/home/deploy/.ssh/dude_deploy_key.pub") do
    it { should exist }
    it { should be_owned_by("deploy") }
    it { should be_grouped_into("deploy") }
    it { should be_mode(600) }
  end
end
