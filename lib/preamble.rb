require 'preamble/version'
require 'yaml'

module Preamble
  
  DEFAULTS = {
    :external_encoding => Encoding.default_external
  }
  
  def self.load(path, options = {})
    preamble_lines = []
    body_lines = []
    options = DEFAULTS.merge(options)
    
    state = :before_preamble
    
    open(path, "r:#{options[:external_encoding]}") do |f|
      f.each do |line|

        stripped = line.strip

        case state

          when :before_preamble

            new_state = case stripped
              when "---"
                :preamble
              when ""
                :before_preamble
              else
                raise "First line must begin with ---"
            end

          when :preamble

            new_state = case stripped
              when "---"
                :after_preamble
              else
                preamble_lines << line
                :preamble
            end

          when :after_preamble
            new_state = :after_preamble
            body_lines << line

          else raise "Invalid State: #{ state }"
        end

        state = new_state
      end
    end

    return [YAML::load(preamble_lines.join), body_lines.join]

  end

  def self.load_multiple(*paths, **options)
    paths.map{ |path| Preamble.load(path, options) }
  end

end
