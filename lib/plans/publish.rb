require 'plans/command'

module Plans
  class Publish < Command
    def do(path)
      # Create the thumbnails first.
      say 'Updating thumbnails.'
      Thumbs.new(shell, options).do(path)

      path = pathname(path)
      toc_flag = options[:toc] ? "--toc" : ""
      open_flag = options[:open]

      plans_path = plans_pathname(options[:'plans-path'])
      check_plans_pathname_exists(plans_path)

      source_file = path + 'README.md'
      check_source_file(source_file)

      doc_type = get_doctype(path)

      # Set the path to the reference doc for this type of document.
      reference_docx = plans_path + doc_type + 'reference.docx'
      check_reference_docx(reference_docx)

      output_dir = path + 'publish'
      # Make the publish directory if it does not exist.
      FileUtils.mkdir output_dir unless Dir.exist? output_dir
      output_file = output_dir + "#{doc_type}.docx"

      # We need to set the current working directory to where the markdown file is so
      # the images render correctly.
      # Pandoc only looks in the current working directory.
      Dir.chdir(path) do
        `pandoc #{toc_flag} #{source_file} --reference-docx=#{reference_docx} --standalone -f markdown -t docx -o #{output_file}`
      end

      # Get the return code from pandoc.
      pandoc_return = $?.to_i
      check_pandoc_return(pandoc_return)

      say "#{doc_type} published.", :green

      # Open the word doc if requested
      `open #{output_file}` if open_flag
    end

    def check_pandoc_return(pandoc_return)
      unless pandoc_return == 0
        say "Problem publishing #{doc_type}. (Pandoc ERR: #{pandoc_return})", :red
        say "  #{source_file}"
        raise_error("Pandoc ERR: #{pandoc_return}")
      end
    end

    def check_reference_docx(reference_docx)
      unless reference_docx.exist?
        say 'Could not find the reference.docx for this type of file in the .plans directory.', :red
        say 'Check to make sure that reference.docx is available here:'
        say "  #{reference_docx}"
        raise_error('Reference.docx not found.')
      end
    end

    def check_source_file(source_file)
      unless File.exist? source_file
        say 'Markdown file to be published does not exist.', :red
        say "  #{source_file}"
        say 'Are you in the right directory?'
        raise_error('README.md not found.')
      end
    end

    # Get the document type from the YAML file next to the document.
    #
    # @param [Pathname] The path to the location of the template.yml file.
    # @return [String] the type of the document found in the YAML file.
    def get_doctype(path)
      doc_type = nil
      begin
        metadata = YAML.load_file(path + 'template.yml')
        doc_type = metadata['type']
        if doc_type.nil?
          say 'Type value not found. Check template.yml in the document directory', :red
          say 'Make sure there is an entry `type: DOC_TYPE` in the file.'
          say "  #{path}"
          raise_error('DOC_TYPE not found in template.yml')
        end
      rescue Errno::ENOENT # File not found
        say 'No template.yml found in the document directory. Did you forget to add it?', :red
        say 'Did you run the command in the directory where the document is located?'
        say "  #{path}"
        raise_error('template.yml not found')
      end
      return doc_type
    end
  end
end
