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
      connector = Sejmometr::Connector.new
      connector.import("#{@member_id}/tablica", nil, Sejmometr::MemberTableEvent, "tablica")
    end
    
  end
end
