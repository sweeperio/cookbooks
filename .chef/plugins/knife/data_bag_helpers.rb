module Chef::Knife::DataBagHelpers
  private

  def read_secret
    Chef::EncryptedDataBagItem.load_secret(Chef::Config[:encrypted_data_bag_secret])
  end

  def bag_item_path(data_bag, data_bag_item)
    File.join(Chef::Config[:data_bag_path], data_bag, "#{data_bag_item}.json")
  end
end
