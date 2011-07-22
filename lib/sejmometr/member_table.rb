module Sejmometr
  class MemberTable
    attr_reader :events
    
    def initialize(member_id)
      @member_id = member_id
      @events = download_member_table
    end
    
    private
    
    def download_page(page)
    end
    
    def download_member_table
      list = true
      url = "http://api.sejmometr.pl/#{@member_id}/tablica?na_strone=100&str="
      i=0
      table = []
      while(list)
        i+=1
        resp = Net::HTTP.get_response(URI.parse(url + "#{i}"))
        data = resp.body
        result = JSON.parse(data) 
        unless result["tablica"].empty?
 	  result["tablica"].each do |event|
            table << Sejmometr::MemberTableEvent.new(event)
          end
        else
          list = false
        end
      end
      table
    end
  end
end
