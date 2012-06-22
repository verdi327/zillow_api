require 'faraday'
require 'nokogiri'

module ZillowApi
  class Client
    BASE_URL = 'http://www.zillow.com'

    def initialize
      @connection = Faraday.new(url: BASE_URL)
    end

    def get_city_data(location)
      response = @connection.get do |req|
        req.url "/webservice/GetDemographics.htm"
        req.headers['Accepts'] = 'application/xml'
        req.params['zws-id']   = 'X1-ZWz1bn1je20hzf_1wtus'
        req.params['state']    = location[:state]
        req.params['city']     = location[:city]
      end
      response.body
    end
  end
end