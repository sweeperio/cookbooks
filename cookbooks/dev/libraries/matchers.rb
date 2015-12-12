if defined?(ChefSpec)
  def install_with_make_ark(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:ark, :install_with_make, resource_name)
  end

  def cherry_pick_ark(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:ark, :cherry_pick, resource_name)
  end

  def create_nginx_site(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:open_resty_site, :create, resource_name)
  end

  def enable_nginx_site(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:open_resty_site, :enable, resource_name)
  end
end
