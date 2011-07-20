module Sejmometr
  class Clubs
  
    def initialize
      @clubs = []
      download_clubs_from_sejmometr_pl
    end
    
    def club(club_id)
      @clubs.detect {|c| c.id == club_id}
    end
    
    def clubs
      @clubs
    end
    
    private

    def download_clubs_from_sejmometr_pl
      list = true
      url = "http://api.sejmometr.pl/kluby"
      resp = Net::HTTP.get_response(URI.parse(url))
      data = resp.body
      result = JSON.parse(data)
      result.each do |club|
        @clubs << Sejmometr::Club.new(club)
      end
      
      p @clubs
    end
      
  end
  
  
end

=begin
  require 'sejmometr'  
  Sejmometr::Clubs.new
=end