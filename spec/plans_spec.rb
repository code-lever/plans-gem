require 'spec_helper'

describe Plans do
  it 'has a version number' do
    expect(Plans::VERSION).not_to be nil
  end

  describe ".source_directory" do
    it 'is a directory' do
      expect(File.directory?(Plans.source_root)).to be_truthy
    end
  end
end
