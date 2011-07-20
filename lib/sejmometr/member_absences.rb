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
      absences = []
      url = "http://api.sejmometr.pl/#{@member_id}/nieobecnosci"
      resp = Net::HTTP.get_response(URI.parse(URI.encode(url)))
      data = resp.body
      result = JSON.parse(data)

      result.each do |absence|
	absences << Sejmometr::MemberAbsence.new(absence)
      end

      absences
    end
  end
end