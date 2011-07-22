module Sejmometr
  class MemberInterpolation
    attr_reader :id, :numer, :tytul, :data_wplywu, :tekst, :zglaszajacy, :adresat

      
    def initialize(json)
      @id = nil
      @numer = nil
      @tytul = nil
      @data_wplywu = nil
      @tekst = nil
      @zglaszajacy = nil
      @adresat = nil
      
      import(json)
    end
    
    def to_json(*a)
      data = {}
      self.instance_variables.each {|var| data[var.to_s[1..-1]] = instance_variable_get(var) }
      {
         "interpellation" => data
      }.to_json(*a)
    end
    
    private
    
    def import(json)
      json.each do |key, value|
	instance_variable_set("@#{key}", value)
      end      
    end
  end
end
