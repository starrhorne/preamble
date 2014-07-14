require 'preamble/version'
require 'yaml'

class Preamble
  
  DEFAULTS = {
    :external_encoding => Encoding.default_external
  }

  attr_accessor :metadata, :content

  def initialize(metadata, content)
    @metadata = metadata
    @content = content
  end

  def metadata_with_content
    @metadata.to_yaml + "---\n" + @content
  end

  def save(path, options = {})
    options = DEFAULTS.merge(options)

    open(path, "w:#{options[:external_encoding]}") do |f|
      f.write metadata_with_content
    end
  end
  
  def self.load(path, options = {})
    preamble_lines = String.new
    content_lines = String.new
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
            content_lines << line

          else
            raise "Invalid State: #{ state }"

        end

        state = new_state
      end
    end

    return new(YAML::load(preamble_lines), content_lines)
  end

  def self.load_multiple(*paths)
    options = paths.last.is_a?(Hash) ? paths.pop : {}
    paths.map{ |path| Preamble.load(path, options) }
  end

end
