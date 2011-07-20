module Sejmometr
  class Member
    attr_reader :avatar_url, :data_urodzenia, :liczba_glosow, :stan_cywilny, :miejsce_urodzenia, :imie, :drugie_imie, :okreg_nr, :zawod, :wyksztalcenie, :klub, :id, :nazwa, :plec, :lista, :data_wygasniecia, :nazwisko, :klub_nazwa, :klub_id, :wiek, :nid, :wojewodztwo_id, :ilosc_oswiadczen, :procent_nieobecnosci, :ilosc_slow, :ilosc_wypowiedzi, :srednia_dlugosc_wypowiedzi, :ilosc_projektow, :ilosc_interpolacji, :data_wybrania, :data_slubowania, :szkola

    def initialize(member_hash = nil)
      @avatar_url = nil
      @data_urodzenia = nil
      @liczba_glosow = nil
      @stan_cywilny = nil
      @miejsce_urodzenia = nil
      @imie = nil
      @drugie_imie = nil
      @okreg_nr = nil
      @zawod = nil
      @wyksztalcenie = nil
      @klub = nil
      @id = nil
      @nazwa = nil
      @plec = nil
      @lista = nil
      @data_wygasniecia = nil
      @nazwisko = nil
      @klub_nazwa = nil
      @klub = nil
      @klub_id = nil
      @wiek = nil
      @nid = nil
      @wojewodztwo_id = nil
      @ilosc_oswiadczen = nil
      @procent_nieobecnosci = nil
      @ilosc_slow = nil
      @ilosc_wypowiedzi = nil
      @srednia_dlugosc_wypowiedzi = nil
      @ilosc_projektow = nil
      @ilosc_interpolacji = nil
      @data_wybrania = nil
      @data_slubowania = nil
      @szkola = nil
      
      if member_hash
	import(member_hash)
      end
    end

    def download
      if @id
        download_member
      end
    end
    
    def to_json(*a)
      data = {}
      self.instance_variables.each {|var| data[var.to_s[1..-1]] = instance_variable_get(var) }
      {
         "member" => data
      }.to_json(*a)
    end

    def absences
      absences = Sejmometr::MemberAbsences.new(@id)
      absences.absences
    end

    private

    def download_member
      url = "http://api.sejmometr.pl/#{@id}/info"
      resp = Net::HTTP.get_response(URI.parse(URI.encode(url)))
      data = resp.body
      result = JSON.parse(data)
      import(result)
    end

    def import(member_hash)
      member_hash.each do |key, value|
	instance_variable_set("@#{key}", value)
      end      
    end

  end
end

=begin
  require 'sejmometr'
  member = Sejmometr::Member.new
  member.id = "Krystyna-Grabicka"
  me
  parliment.count
  parliment.club_members("PO")
=end

