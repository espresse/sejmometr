module Sejmometr
  class MemberSignedProjects
    attr_reader :projects
    
    def initialize(member_id)
      @member_id = member_id
      @projects = download_member_signed_projects
    end
    
    private
    
    def download_member_signed_projects
      connector = Sejmometr::Connector.new
      connector.import("#{@member_id}/projekty", nil, Sejmometr::MemberSignedProject, "projekty")
    end
    
  end
end
