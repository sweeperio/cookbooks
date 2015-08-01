require "spec_helper"

describe "base::packages" do
  %w(curl).each do |pkg|
    describe package(pkg) do
      it { should be_installed }
    end
  end
end
