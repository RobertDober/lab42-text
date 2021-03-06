$:.unshift File.expand_path( "../../lib", __FILE__ )
require 'lab42/text'

PROJECT_ROOT = File.expand_path "../..", __FILE__

Dir[File.join(PROJECT_ROOT,"spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
  c.filter_run wip: true
  c.filter_run_excluding meta: true 
  c.run_all_when_everything_filtered = true

end

