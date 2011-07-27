module Sejmometr
  class Connector
    def initialize
      @url = "http://api.sejmometr.pl/"
    end
    
    def import(subpage, params, obj = nil, result_table=nil)
      @subpage = subpage
      @params = "?"
      @params += params if params
      @result_table = result_table
      @obj = obj
      
      if @result_table
        result = download_pages
      else
        result = download_page
      end
    end
    
    def check_connection
      resp = Net::HTTP.get_response(URI.parse(URI.encode(@url)))
      
      case resp
      when Net::HTTPSuccess, Net::HTTPRedirection
         if resp.body == "false"
           false
         else
           true
         end
      else
        resp.error!
      end
      
    end
    
    private
    
    def download_page
      url = @url + @subpage + @params
      resp = Net::HTTP.get_response(URI.parse(URI.encode(url)))
      data = resp.body
      result = JSON.parse(data)
      
      if @obj
        elements = []
        result.each do |element|
          elements << @obj.new(element)
        end
        elements
      else
        result
      end
    end
    
    def download_pages
      params = "&na_strone=100&str="
      
      list = true
      url = @url + @subpage + @params + params
      i=0
      elements = []
      while(list)
        i+=1
        resp = Net::HTTP.get_response(URI.parse(url + "#{i}"))
        data = resp.body
        result = JSON.parse(data)
        unless result[@result_table].empty?
          result[@result_table].each do |element|
            elements << @obj.new(element)
          end
        else
          list = false
        end        
      end
      elements
    end
  end
end
