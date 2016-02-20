require "spec_helper"

describe Plans::CLI, type: :aruba do

  before :each do
    allow(Plans).to receive(:plans_dir) { Pathname('.plans') }
  end

  before(:all) do
    # Enable these to have aruba print this information as the specs run.
    # announcer.activate(:command)
    # announcer.activate(:stdout)
    # announcer.activate(:stderr)
  end

  describe '#init' do
    it 'creates a directory' do
      run_simple 'plans init --plans-path=./tmp'
      expect('./tmp/.plans').to be_an_existing_directory
    end

    it 'fails if the directory already exists' do
      run_simple 'plans init --plans-path=./tmp'
      expect(last_command_started).to be_successfully_executed
      expect('./tmp/.plans').to be_an_existing_directory
      run 'plans init --plans-path=./tmp'
      expect(last_command_started).to_not be_successfully_executed
      expect(last_command_started).to have_output /The .plans directory already exists!/
      expect('./tmp/.plans').to be_an_existing_directory
    end
  end

  describe '#list' do
    context 'plans directory exists' do
      before :each do
        run_simple 'plans init --plans-path=./tmp'
      end

      it 'lists the document types available' do
        run_simple 'plans list --plans-path=./tmp'
        expect(last_command_started).to have_output /functional/
        expect(last_command_started).to have_output /glossary/
        expect(last_command_started).to have_output /scope/
        expect(last_command_started).to have_output /users/
      end
    end

    it 'fails if the plans directory does not exist' do
      run 'plans list --plans-path=./tmp'
      expect(last_command_started).to_not be_successfully_executed
      expect(last_command_started).to have_output /The .plans directory does not exist./
    end
  end

  describe '#new' do
    context 'plans directory exists' do
      before :each do
        run_simple 'plans init --plans-path=./tmp'
      end

      it 'creates a new document' do
        run_simple 'plans new scope --plans-path=./tmp'
        expect('./scope').to be_an_existing_directory
        expect('./scope/README.md').to be_an_existing_file
        expect('./scope/template.yml').to be_an_existing_file
        expect('./scope/reference.docx').to_not be_an_existing_file
        expect('./scope/img').to be_an_existing_directory
        expect('./scope/publish').to be_an_existing_directory
      end

      it 'does not create document, if the template is not known' do
        run 'plans new foobar --plans-path=./tmp'
        expect(last_command_started).to_not be_successfully_executed
        expect(last_command_started).to have_output /Cannot create DOC_TYPE foobar/
      end

    end

    it 'fails if the plans directory does not exist' do
      run 'plans new scope --plans-path=./tmp'
      expect(last_command_started).to_not be_successfully_executed
      expect(last_command_started).to have_output /The .plans directory does not exist./
    end
  end

  describe '#thumbs' do
    before :each do
      run_simple 'plans init --plans-path=./tmp'
      run_simple 'plans new scope --plans-path=./tmp'
    end

    it 'Does not do anything if there are no images' do
      run_simple 'plans thumbs ./scope  --plans-path=./tmp'
      expect(last_command_started).to have_output /Nothing to do/
      expect('./scope/img/200px').to_not be_an_existing_directory
      expect('./scope/img/400px').to_not be_an_existing_directory
      expect('./scope/img/600px').to_not be_an_existing_directory
    end

    it 'Makes the thumbnails' do
      copy '%/img/cat-looking-up.jpg', './scope/img'
      run_simple 'plans thumbs ./scope  --plans-path=./tmp'
      expect(last_command_started).to have_output /Thumbnails creation complete./
      expect('./scope/img/200px').to be_an_existing_directory
      expect('./scope/img/400px').to be_an_existing_directory
      expect('./scope/img/600px').to be_an_existing_directory
      expect('./scope/img/200px/cat-looking-up.jpg').to be_an_existing_file
      expect('./scope/img/400px/cat-looking-up.jpg').to be_an_existing_file
      expect('./scope/img/600px/cat-looking-up.jpg').to be_an_existing_file
    end

    it 'still makes the thumbnails w/o the plans directory' do
      FileUtils.rm_rf './tmp/.plans'
      copy '%/img/cat-looking-up.jpg', './scope/img'
      run_simple 'plans thumbs ./scope --plans-path=./not_valid_tmp'
      expect(last_command_started).to have_output /Thumbnails creation complete./
      expect('./scope/img/200px').to be_an_existing_directory
      expect('./scope/img/400px').to be_an_existing_directory
      expect('./scope/img/600px').to be_an_existing_directory
      expect('./scope/img/200px/cat-looking-up.jpg').to be_an_existing_file
      expect('./scope/img/400px/cat-looking-up.jpg').to be_an_existing_file
      expect('./scope/img/600px/cat-looking-up.jpg').to be_an_existing_file
    end

  end

  describe '#publish' do
    before :each do
      run_simple 'plans init --plans-path=./tmp'
      run_simple 'plans new scope --plans-path=./tmp'
    end

    it 'creates a word document in the publish sub directory' do
      run_simple 'plans publish ./scope --no-open --plans-path=./tmp'
      expect(last_command_started).to have_output /scope published/
      expect('./scope/publish/scope.docx').to be_an_existing_file
    end

    it 'fails if the plans directory does not exist' do
      run 'plans publish ./scope --no-open --plans-path=./not_valid_tmp'
      expect(last_command_started).to_not be_successfully_executed
      expect(last_command_started).to have_output /The .plans directory does not exist./
    end

  end

end

