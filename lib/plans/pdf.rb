require 'plans/publish'

module Plans
  class Pdf < Publish

    def do(path)
      # Create the thumbnails first.
      say 'Updating thumbnails.'
      Thumbs.new(shell, options).do(path)

      path = pathname(path)
      toc_flag = options[:toc] ? "--toc" : ""
      open_flag = options[:open]

      source_file = path + 'README.md'
      check_source_file(source_file)

      doc_type = get_doctype(path)

      output_dir = path + 'publish'
      # Make the publish directory if it does not exist.
      FileUtils.mkdir output_dir unless Dir.exist? output_dir
      output_file = output_dir + "#{doc_type}.pdf"

      # We need to set the current working directory to where the markdown file is so
      # the images render correctly.
      # Pandoc only looks in the current working directory.
      Dir.chdir(path) do
        `pandoc #{toc_flag} #{source_file} --standalone --latex-engine=xelatex -o #{output_file}`
      end

      # Get the return code from pandoc.
      pandoc_return = $?.to_i
      check_pandoc_return(pandoc_return)

      say "#{doc_type} published as PDF.", :green

      # Open the PDF if requested
      `open #{output_file}` if open_flag
    end

  end
end
