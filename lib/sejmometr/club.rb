module Sejmometr
  class Club
    attr_accessor :id, :nazwa, :kolo, :ilosc_poslow, :srednia_wieku, :udzial_kobiet, :udzial_singli, :udzial_ww
    attr_accessor :srednia_ilosc_slow, :srednia_ilosc_wypowiedzi, :srednia_dlugosc_wypowiedzi, :srednia_nieobecnosci, :srednia_ilosc_projektow, :srednia_ilosc_interpelacji
  
    def initialize(club_hash = nil)
      @id = nil
      @nazwa = nil
      @kolo = nil
      @ilosc_poslow = nil
      @srednia_wieku = nil
      @udzial_kobiet = nil
      @udzial_singli = nil
      @udzial_ww = nil
      @srednia_ilosc_slow = nil
      @srednia_ilosc_wypowiedzi = nil
      @srednia_dlugosc_wypowiedzi = nil
      @srednia_nieobecnosci = nil
      @srednia_ilosc_projektow = nil
      @srednia_ilosc_interpelacji = nil
      
      @members = []
      
      if club_hash
        club_hash.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end
      
    end
    
    def id=(id)
      @id = id
      download_club_from_sejmometr_pl
    end
    
    def import(club_hash = nil)
      if club_hash
        club_hash.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      else
        download_club_from_sejmometr_pl
      end
    end
    
    def members
      if @members.empty?
        @members = download_club_members_from_sejmometr_pl
      else
        @members
      end
    end
    
    
    
    private

    def download_club_from_sejmometr_pl
      url = "http://api.sejmometr.pl/#{id}/"
      resp = Net::HTTP.get_response(URI.parse(url))
      data = resp.body
      result = JSON.parse(data)
      result.each do |club|
        
      end
    end
    
    def download_club_members_from_sejmometr_pl
      url = "http://api.sejmometr.pl/#{@id}/poslowie"
      members = []
      resp = Net::HTTP.get_response(URI.parse(url))
      data = resp.body
      result = JSON.parse(data) 
      unless result["poslowie"].empty?
 	result["poslowie"].each do |posel|
          members << Sejmometr::Member.new(posel)
        end
      else
        list = false
      end
      
      members
    end
    
    
      
  end
  
  
end

=begin
  require 'sejmometr'  
  Sejmometr::Clubs.new
=end