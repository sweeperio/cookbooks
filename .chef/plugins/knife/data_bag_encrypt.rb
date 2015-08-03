require "chef/knife"
require_relative "data_bag_helpers"

class Chef::Knife::DataBagEncrypt < Chef::Knife
  include Chef::Knife::DataBagHelpers

  banner "knife data bag encrypt DATA_BAG ITEM (options)"
  category "data bag"

  option :write, short: "-w", long: "--write", boolean: true, default: false

  def run
    data_bag, item = @name_args
    cipher_text_bag = read_item(data_bag, item)

    if config[:write]
      path = bag_item_path(data_bag, item)
      json = JSON.pretty_generate(cipher_text_bag.to_hash)
      File.open(path, "w") { |file| file.write(json) }
      output(json)
    else
      output(format_for_display(cipher_text_bag))
    end
  end

  private

  def read_item(data_bag, data_bag_item)
    raw = JSON.parse(File.read(bag_item_path(data_bag, data_bag_item)))
    bag = Chef::DataBagItem.from_hash(raw)
    Chef::EncryptedDataBagItem.encrypt_data_bag_item(bag, read_secret)
  end
end
