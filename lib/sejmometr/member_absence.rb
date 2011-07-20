module Sejmometr
  class MemberAbsence
    attr_reader :id, :numer, :data_tytul, :procent_nieobecnosci, :ilosc_glosowan, :ilosc_nieobecnosci
    
    def initialize(json)
      @id = nil
      @numer = nil
      @data_tytul = nil
      @procent_nieobecnosci = nil
      @ilosc_glosowan = nil
      @ilosc_nieobecnosci = nil

      import(json)
    end

    def to_json(*a)
      data = {}
      self.instance_variables.each {|var| data[var.to_s[1..-1]] = instance_variable_get(var) }
      {
         "absence" => data
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