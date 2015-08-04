use_inline_resources

def ejson_keys
  @ejson_keys ||= begin
    Chef::EncryptedDataBagItem.load("ejson", "keys")
  end
end

action :add do
  name = new_resource.name
  key_data = ejson_keys[name]

  sub_action = file("/opt/ejson/keys/#{key_data['public']}") do
    content key_data["private"]
    mode 0440
    owner "deploy"
    group "deploy"
  end

  new_resource.updated_by_last_action(sub_action.updated_by_last_action?)
end

action :remove do
  name = new_resource.name
  key_data = ejson_keys.fetch(name)

  sub_action = file("/opt/ejson/keys/#{key_data['public']}") do
    action :delete
  end

  new_resource.updated_by_last_action(sub_action.updated_by_last_action?)
end
