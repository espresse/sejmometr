module Sejmometr
  class Members
    attr_reader :list

    def initialize
      @list = []
    end

    def download(force=false)
      if force
        @list = download_member_list
      else
        if @list.empty?
          @list = download_member_list
        end
      end
    end

    def find(id)
      @list.detect {|m| m.id == id}
    end

    def find_by_surname(surname)
      members = []
      @list.each do |m|
        if m.nazwisko == surname
          members << m
        end
      end
      members
    end

    def find_by_club_id(club_id)
      members = []
      @list.each do |m|
	p m.id
        if m.klub == club_id
          members << m
        end
      end
      members
    end

    def count
      @list.count
    end

    def to_json(*a)
      data = {}
      @members.map {|member| data+={"member" => member.to_json}}
      {
         "members" => data
      }.to_json(*a)
    end


    private
 
    def download_member_list
      connector = Sejmometr::Connector.new
      connector.import("poslowie", nil, Sejmometr::Member, "poslowie")
    end
  end
end

