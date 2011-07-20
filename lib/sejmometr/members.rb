module Sejmometr
  class Members
    attr_reader :list

    def initialize
      @list = []
    end

    def download(insist=false)
      if insist
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
      list = true
      url = "http://api.sejmometr.pl/poslowie?na_strone=100&str="
      i=0
      members = []
      while(list)
        i+=1
        resp = Net::HTTP.get_response(URI.parse(url + "#{i}"))
        data = resp.body
        result = JSON.parse(data) 
        unless result["poslowie"].empty?
 	  result["poslowie"].each do |posel|
            members << Sejmometr::Member.new(posel)
          end
        else
          list = false
        end
      end
      members
    end

  end
end

=begin
  require 'sejmometr'
  parliment = Sejmometr::Members.new
  parliment.download
  parliment.count
  parliment.find_by_club_id("PO")
=end
