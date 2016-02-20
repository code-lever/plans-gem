require 'aruba'

Aruba.configure do |config|
  # This will allow us to copy files using Aruba's % path operator to start at the specs directory.
  config.fixtures_directories = %w(spec/fixtures)
  # Aruba looks for the gem executable in 'bin', but bundler has moved it to 'exe'
  config.command_search_paths << 'exe'
end

