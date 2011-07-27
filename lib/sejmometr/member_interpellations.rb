module Sejmometr
  class MemberInterpellations
    attr_reader :interpellations
    
    def initialize(member_id)
      @member_id = member_id
      @interpellations = download_member_interpellations
    end
    
    private
    
    def download_member_interpellations
      connector = Sejmometr::Connector.new
      connector.import("#{@member_id}/interpelacje", nil, Sejmometr::MemberInterpellation, "interpelacje")
    end
  end
end
