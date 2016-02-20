require 'plans/command'

module Plans
  class Init < Command
    def do
      plans_path = plans_pathname(options[:'plans-path'])
      if plans_path.exist?
        say 'The .plans directory already exists!', :red
        say 'If you want to recreate it, you will need to manually delete it first.'
        say 'The .plans directory is located here:'
        say "  #{plans_path}"
        raise_error('Plans directory exists.')
      end
      FileUtils.makedirs(plans_path)
      template_path = pathname(Plans.source_root) + 'template/.'
      FileUtils.cp_r(template_path, plans_path)
    end
  end
end
