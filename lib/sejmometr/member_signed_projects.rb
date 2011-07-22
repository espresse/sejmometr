module Sejmometr
  class MemberSignedProjects
    attr_reader :projects
    
    def initialize(member_id)
      @member_id = member_id
      @projects = download_member_signed_projects
    end
    
    private
    
    def download_member_signed_projects
      list = true
      url = "http://api.sejmometr.pl/#{@member_id}/projekty?na_strone=100&str="
      i=0
      projects = []
      while(list)
        i+=1
        resp = Net::HTTP.get_response(URI.parse(url + "#{i}"))
        data = resp.body
        result = JSON.parse(data) 
        unless result["projekty"].empty?
 	  result["projekty"].each do |event|
            projects << Sejmometr::MemberSignedProject.new(event)
          end
        else
          list = false
        end
      end
      projects
    end
  end
end
