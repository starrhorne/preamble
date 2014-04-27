require_relative '../lib/preamble'
require_relative 'sample_files'

RSpec.configure do |c|
  c.include SampleFiles
end