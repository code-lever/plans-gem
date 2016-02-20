require 'thor'
require 'plans/new'
require 'plans/list'
require 'plans/init'
require 'plans/publish'
require 'plans/thumbs'
require 'plans/pdf'

module Plans
  class CLI < Thor
    include Thor::Actions

    # Set the source root for Thor::Actions
    def self.source_root
      Plans.source_root
    end

    # Override for Thor.
    # Have the application exit and return an error code on failure.
    def self.exit_on_failure?
      true
    end

    class_option :'plans-path',
                 {:type => :string,
                  :desc => 'The path to the .plans directory which contains the plans templates. This is your home directory by default.'}


    desc 'new DOC_TYPE', 'Creates a new document of the specified type in the current directory.'
    long_desc <<-NEW
    `plans new DOC_TYPE` creates a new document of the specified type.

    To see the available document types try `plans list`.

    > $ plans new scope
    NEW

    def new(doc_type)
      New.new(shell, options).do(doc_type)
    end

    desc 'list', 'List all of the document types available.'
    long_desc <<-LIST
    `plans list` Lists all the documents types available.

    > $ plans list
    LIST

    def list
      List.new(shell, options).do
    end


    desc 'init', 'Create the .plans folder in your home directory and initialize it with the default document templates'
    long_desc <<-INIT
    `plans init` Creates the .plans folder in your home directory and initializes it with the default document templates.
    Once you have the templates customized the way you like them, its probably a good idea to put this directory
    into version control.

    If the directory already exists, the command does nothing.

    > $ plans init
    INIT

    def init
      Init.new(shell, options).do
    end

    desc 'publish', 'Create an MS Word version of the document'
    long_desc <<-PUBLISH
    `plans publish` will create a MS Word version of the document.

    The document type is determined by inspecting the template.yml.

    Overwrites any previously published versions of the Word document.

    > $ plans publish
    PUBLISH
    method_option :toc,
                  {:type => :boolean,
                   :default => false,
                   :desc => 'Add a table of contents to the MS Word document. Not included by default.'}
    method_option :open,
                  {:type => :boolean,
                   :default => true,
                   :desc => 'Open the published document after it has been rendered by Pandoc.'}

    def publish(path = '.')
      Publish.new(shell, options).do(path)
    end

    desc 'thumbs', 'Creates reduced size copies of each of the images in the img directory'
    long_desc <<-THUMBS
        `plans thumbs` will create reduced size versions of
        each of the images in the document's img directory. Markdown isn't
        very good at scaling images, so images of a known width are useful.
        Images like desktop screenshots are often too large to fit on the
        printed or published page without being manually scaled.

        The command creates three subdirectories in the
        documents img directory, one for each size of scaled image. These
        are 200px, 400px, and 600px. To use these in the document, just
        use the standard markdown syntax for including an image. The following
        shows how to include a 400px wide version of a screenshot

        `![A Screenshot](./img/400px/Fullscreen_10_12_15__11_34_AM.png)`

        The thumbnail directories are removed each time the thumbnails are
        generated, so do not place additional files in these directories.

        > $ plans thumbs
    THUMBS

    def thumbs(path = '.')
      Thumbs.new(shell, options).do(path)
    end


    desc 'pdf', 'Create an PDF version of the document'
    long_desc <<-PDF
    `plans pdf` will create a PDF version of the document.

    The document type is determined by inspecting the template.yml.

    Overwrites any previously published versions of the PDF document.

    > $ plans pdf
    PDF
    method_option :toc,
                  {:type => :boolean,
                   :default => false,
                   :desc => 'Add a table of contents to the PDF document. Not included by default.'}
    method_option :open,
                  {:type => :boolean,
                   :default => true,
                   :desc => 'Open the published document after it has been rendered by Pandoc.'}

    def pdf (path = '.')
      Pdf.new(shell, options).do(path)
    end

  end
end



