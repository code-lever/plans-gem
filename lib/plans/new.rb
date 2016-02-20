require 'plans/command'

module Plans
  class New < Command

    def do(doc_type)
      plans_path = plans_pathname(@options[:'plans-path'])
      check_plans_pathname_exists plans_path

      doc_path = plans_path + doc_type
      check_doc_path_exists(doc_path, plans_path, doc_type)

      # Set the Thor::Actions destination root to the current working directory.
      self.destination_root = '.'
      # copy the template directory, but don't include the reference word docs.
      directory(doc_path, "./#{doc_type}", :exclude_pattern => /docx/)
    end

    def check_doc_path_exists(doc_path, plans_path, doc_type)
      unless doc_path.exist?
        say "Cannot create DOC_TYPE #{doc_type} because this template does not exist.", :red
        say 'Try `plans list` to see the available DOC_TYPEs or'
        say 'check the templates in the .plans directory here:'
        say "  #{plans_path}"
        raise_error("DOC_TYPE #{doc_type} does not exist.")
      end
    end
  end
end