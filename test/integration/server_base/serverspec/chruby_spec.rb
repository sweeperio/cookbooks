require "spec_helper"

CHRUBY_FILES = %w(
  /etc/profile.d/chruby.sh
  /usr/local/share/chruby/chruby.sh
  /usr/local/share/chruby/auto.sh
)

describe "base::chruby" do
  let(:path) { "/opt/rubies/2.2.2/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" }

  CHRUBY_FILES.each do |path|
    describe file(path) do
      it { should be_file }
    end
  end

  describe command("which bundle") do
    its(:stdout) { should eq("/opt/rubies/2.2.2/bin/bundle\n") }
  end

  describe command("which ejson") do
    its(:stdout) { should eq("/opt/rubies/2.2.2/bin/ejson\n") }
  end

  describe command("ruby -v") do
    its(:exit_status) { should eq(0) }
    its(:stdout) { should match(/^ruby 2\.2\.2/) }
  end
end
