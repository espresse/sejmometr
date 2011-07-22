module Sejmometr
  class MemberSignedProject
    attr_reader :id, :dokument_id, :autor, :numer, :tytul, :opis, :status_slowny, :data_wplynal, :url_title
    
    def initialize(json)
      @id = nil
      @dokument_id = nil
      @autor = nil
      @numer = nil
      @tytul = nil
      @opis = nil
      @status_slowny = nil
      @data_wplynal = nil
      @url_title = nil
      
      import(json)
    end
    
    def to_json(*a)
      data = {}
      self.instance_variables.each {|var| data[var.to_s[1..-1]] = instance_variable_get(var) }
      {
         "event" => data
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
