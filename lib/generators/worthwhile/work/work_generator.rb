# -*- encoding : utf-8 -*-
require 'rails/generators'

class Rails::Generators::NamedBase
  private
  def destroy(what, *args)
    log :destroy, what
    argument = args.map {|arg| arg.to_s }.flatten.join(" ")

    in_root {
      run_ruby_script("bin/rails destroy #{what} #{argument}", verbose: true)
    }
  end
end

class Worthwhile::WorkGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)


  argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"

  # Why all of these antics with defining individual methods?
  # Because I want the output of Worthwhile::WorkGenerator to include all the processed files.
  def create_model_spec
    return unless rspec_installed?
    template "model_spec.rb.erb", "spec/repository_models/#{file_name}_spec.rb"
  end

  def create_model
    template("model.rb.erb", "app/repository_models/#{file_name}.rb")
  end
  def create_controller_spec
    return unless rspec_installed?
    template("controller_spec.rb.erb", "spec/controllers/curation_concern/#{plural_file_name}_controller_spec.rb")
  end

  def create_actor_spec
    return unless rspec_installed?
    template("actor_spec.rb.erb", "spec/actors/curation_concern/#{file_name}_actor_spec.rb")
  end

  def create_controller
    template("controller.rb.erb", "app/controllers/curation_concern/#{plural_file_name}_controller.rb")
  end

  def create_actor
    template("actor.rb.erb", "app/actors/curation_concern/#{file_name}_actor.rb")
  end

  def register_work
    inject_into_file 'config/initializers/worthwhile_config.rb', after: "Worthwhile.configure do |config|\n" do
      data = ""
      data << "  # Injected via `rails g worthwhile:work #{class_name}`\n"
      data << "  config.register_curation_concern :#{file_name}\n"
      data
    end
  end

  def create_views
    create_file "app/views/curation_concern/#{plural_file_name}/_#{file_name}.html.erb" do
      data = "<%# This is a search result view %>\n"
      data << "<%= render 'catalog/document', document: #{file_name}, document_counter: #{file_name}_counter  %>\n"
      data
    end
  end

  def create_readme
    readme 'README'
  end


  private

    def rspec_installed?
      defined?(RSpec) && defined?(RSpec::Rails)
    end

end
