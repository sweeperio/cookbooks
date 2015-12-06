require "spec_helper"

describe "dev" do
  APPS     = %w(memcached phantomjs redis-server redis-cli tmux fasd node coffee grunt)
  SERVICES = %w(memcached redis6379)

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
end
