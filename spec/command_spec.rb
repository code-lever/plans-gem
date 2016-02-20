require "spec_helper"

describe Plans::Command do
  describe '#plans_pathname' do

    let(:c) {Plans::Command.new(nil, nil)}
    it 'is in the home directory if not initialized with a path' do
      expect(c.plans_pathname).to eq(Pathname(Dir.home) + '.plans')
    end

    it 'is the directory if specified' do
      expect(c.plans_pathname('./tmp')).to eq(Pathname(File.expand_path('./tmp')) + '.plans')
    end
  end
end