module SampleFiles

  SAMPLE_FILES = {
    standard: "standard.txt",
    leading_whitespace: "leading_whitespace.txt",
    unicode: "unicode.txt"
  }
  
  SAMPLE_FILES.each do |method, filename|
    define_method(method) { full_path filename }
  end

  def full_path filename
    "#{File.dirname(__FILE__)}/sample_files/#{filename}"
  end

end