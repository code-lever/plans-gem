$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
Dir.glob(::File.expand_path('../support/*.rb', __FILE__)).each { |f| require_relative f }
Dir.glob(::File.expand_path('../shared_example/*.rb', __FILE__)).each { |f| require_relative f }
require 'plans'
