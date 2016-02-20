require 'thor'

module Plans
  class Command
    # To get your hands on the `from_superclass` method
    include Thor::Base

    # Allow us to use nice Thor helper methods like 'directory'
    include Thor::Actions

    # Set the source root for Thor::Actions
    def self.source_root
      Plans.source_root
    end

    attr_reader :shell, :options

    # Initialize the command with the
    # Thor::Shell and the options.
    def initialize(shell, options)
      @shell = shell
      @options = options
    end

    # Check to see if the .plans path exists
    # Prints a message for the user and raises if it does not.
    #
    # @param [Pathname] path the proposed path to the .plans directory.
    def check_plans_pathname_exists(path)
      unless path.exist?
        say 'The .plans directory does not exist.', :red
        say 'Run `plans init` to create a .plans folder in your home directory and initialize it with the default document templates.'
        say "  #{@path}"
        raise_error('Plans directory does not exist.')
      end
    end

    # The full current path, as a pathname object.
    # @return [Pathname] The full path to the directory where the command is to be executed.
    def pathname(path)
      Pathname(File.expand_path(path))
    end

    # Get the path as a pathname object to the
    # .plans directory.
    #
    # @param [String] path The string path to the .plans directory
    #   or nil if the users home directory should be used.
    def plans_pathname(path = nil)
      path = path || Dir.home
      pathname(path) + '.plans'
    end

    # Raise a formatted Thor exception.
    #
    # @param [String] msg the message to include in the exception.
    def raise_error(msg)
      raise Thor::Error, "Error: #{msg}"
    end
  end
end
