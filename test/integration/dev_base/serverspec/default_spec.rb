require "spec_helper"

describe "dev" do
  APPS     = %w(memcached phantomjs psql redis-server redis-cli tmux fasd node coffee grunt)
  SERVICES = %w(memcached postgresql redis6379)

  RSpec::Matchers.define :match_key_value do |key, value|
    match do |actual|
      actual =~ /^\s*#{key}\s*=\s*#{value}/
    end
  end

  APPS.each do |app|
    describe command("which #{app}") do
      its(:stdout) { should_not eq("") }
    end
  end

  SERVICES.each do |service|
    describe service(service) do
      it { should be_enabled }
      it { should be_running }
    end
  end

  context "postgresl" do
    describe command("sudo -i psql -V") do
      its(:stdout) { should contain("9.3.10") }
    end

    describe file("/etc/postgresql/9.3/main/postgresql.conf") do
      it { should exist }
      its(:content) { should match_key_value("listen_addresses", "'*'") }
      its(:content) { should match_key_value("ssl", "on") }
    end

    describe file("/etc/postgresql/9.3/main/pg_hba.conf") do
      it { should exist }
      its(:content) { should match(/^local\s*all\s*postgres\s*ident/) }
      its(:content) { should match(/^local\s*all\s*all\s*ident/) }
      its(:content) { should match(/^host\s*all\s*all\s*127.0.0.1\/32\s*md5/) }
      its(:content) { should match(/^host\s*all\s*all\s*::1\/128\s*md5/) }
      its(:content) { should match(/^host\s*all\s*all\s*192.168.0.0\/16\s*trust/) }
    end
  end
end
