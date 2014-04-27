require_relative '../spec_helper'

describe Preamble do
  
  describe "#load" do
    
    it "should parse the preamble of a single file" do
      result = Preamble.load(standard)    
    end
    
    it "should return the result as an array" do
      result = Preamble.load(standard)
      expect(result).to be_a Array 
    end
    
    it "should return an array with two values" do
      result = Preamble.load(standard)
      expect(result.size).to eq 2 
    end
    
    it "should return an array with a hash as the first value" do
      result = Preamble.load(standard)
      expect(result[0]).to be_a Hash      
    end
    
    it "should return an array with a string as the first value" do
      result = Preamble.load(standard)
      expect(result[1]).to be_a String      
    end

    it "should accept leading whitespace" do
      Preamble.load(leading_whitespace)
    end
    
    it "should accept an options hash" do
      Preamble.load(standard, {})
    end
    
    it "should accept an encoding option" do
      Preamble.load(standard, {:external_encoding => 'UTF-8'})
    end
    
    it "should read a UTF-8 character" do
      result = Preamble.load(unicode, {:external_encoding => 'UTF-8'})
      expect(result[0]['unicode_tm']).to eq "™"
    end
    
  end
  
  describe "#load_multiple" do
    
    it "should load multiple files" do
      Preamble.load_multiple(standard, leading_whitespace, unicode)
    end
    
    it "should accept options as tail arguments" do
      Preamble.load_multiple(standard, leading_whitespace, unicode, external_encoding: 'UTF-8')
    end
    
  end
  
end