require "spec_helper"

describe "ejson setup" do
  describe file("/opt/ejson/keys") do
    it { should_exist }
    it { should be_directory }
    it { should be_owned_by("deploy") }
    it { should be_grouped_into("deploy") }
    it { should be_mode(550) }
  end
end
