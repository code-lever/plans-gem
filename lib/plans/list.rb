require 'plans/command'
require 'yaml'

module Plans
  class List < Command

    def do
      plans_path = plans_pathname(options[:'plans-path'])
      check_plans_pathname_exists plans_path

      say 'Listing all available DOC_TYPEs...'
      say ''
      plans_path.each_child { |x| list_template(x) }
      say ''
      say 'Create a new document from a template with the command `plans new DOC_TYPE`'
    end

    def list_template(path_name)
      # must be a Pathname
      return unless path_name.is_a? Pathname
      # must be a directory
      return unless path_name.directory?

      doc_type = path_name.basename
      say "DOC_TYPE: #{doc_type}"

      begin
        metadata = YAML.load_file(path_name + 'template.yml')
        title = metadata['title'] || 'Title not found. Check template.yml.'
        description = metadata['description'] || 'Description not found. Check template.yml.'
        say "  Title: #{title}"
        say "  Description: #{description}"
      rescue Errno::ENOENT # File not found
        say 'No template.yml found in the template directory. Did you forget to add it?', :red
      end

      unless (path_name + 'README.md').file?
        say 'No README.md found in the template directory. Did you forget to add it?', :red
      end

      unless (path_name + 'reference.docx').file?
        say 'No reference.docx found in template directory. Did you forget to add it?', :red
      end
    end
  end
end

