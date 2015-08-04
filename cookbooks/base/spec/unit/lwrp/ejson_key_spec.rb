require "spec_helper"

describe "base::ejson" do
  before do
    expect(Chef::EncryptedDataBagItem).to receive(:load).with("ejson", "keys").and_return(
      "id" => "keys",
      "app" => {
        "public" => "public_key",
        "private" => "private_key"
      }
    )
  end

  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new(
      cookbook_path: ["..", "spec/support/cookbooks/"],
      step_into: %w(base_ejson_key)
    )

    runner.converge(described_recipe)
  end

  it "creates the ejson key" do
    expect(chef_run).to create_file("/opt/ejson/keys/public_key").with(
      content: "private_key",
      mode: 0440,
      owner: "deploy",
      group: "deploy"
    )
  end
end
