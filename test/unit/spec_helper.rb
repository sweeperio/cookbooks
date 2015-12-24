require "chefspec"

Dir["./test/unit/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.platform = "ubuntu"
  config.version  = "14.04"
end
