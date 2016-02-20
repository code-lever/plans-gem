require 'plans/version'
require 'plans/cli'
require 'thor'

module Plans

  # Determine where gem is installed.
  #
  # @return The path to the gem.
  def self.source_root
    File.absolute_path(File.join(File.dirname(__FILE__), '..'))
  end

end

