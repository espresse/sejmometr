module Sejmometr
  class MemberTableEvent
    attr_reader :typ_id, :eid, :date, :title, :desc
    
    def initialize(json)
      @typ_id = nil
      @eid = nil
      @date = nil
      @title = nil
      @desc = nil
      
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
