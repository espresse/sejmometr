module Sejmometr
  class MemberInterpellations
    attr_reader :interpellations
    
    def initialize(member_id)
      @member_id = member_id
      @interpellations = download_member_interpellations
    end
    
    private
    
    def download_member_interpellations
      list = true
      url = "http://api.sejmometr.pl/#{@member_id}/interpelacje?na_strone=100&str="
      i=0
      interpolations = []
      while(list)
        i+=1
        resp = Net::HTTP.get_response(URI.parse(url + "#{i}"))
        data = resp.body
        result = JSON.parse(data) 
        unless result["interpelacje"].empty?
 	  result["interpelacje"].each do |event|
            interpolations << Sejmometr::MemberInterpellation.new(event) unless event.nil?
          end
        else
          list = false
        end
      end
      interpolations
    end
  end
end
