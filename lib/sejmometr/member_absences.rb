module Sejmometr
  class MemberAbsences
    attr_reader :absences
    
    def initialize(member_id)
      @member_id = member_id
      @absences = download_member_absences
    end

    def to_json(*a)
      data = {}
      @absences.map {|absence| data+={"absence" => absence.to_json}}
      {
         "absences" => data
      }.to_json(*a)
    end

    private
    
    def download_member_absences
      connector = Sejmometr::Connector.new
      connector.import("#{@member_id}/nieobecnosci", nil, Sejmometr::MemberAbsence, nil)
    end

  end
end