require 'nokogiri'

module ZillowApi
  class National
    attr_accessor :single_males, :single_females, :median_age, :average_commute_time, :home_value

    def initialize(attributes)
      self.average_commute_time = attributes['average commute time (minutes)']
      self.single_females       = attributes['single females']
      self.single_males         = attributes['single males']
      self.median_age           = attributes['median age']
      self.home_value           = attributes['zillow home value index']
    end

    class << self

      def client
        ZillowApi::Client.new
      end

      def demo_attributes(location='chicago', api_key)
        keys = parsed_response(location, api_key).search("page")[-1].search("table")[0].search("attribute").map {|key| key.child.text.downcase }
        values = parsed_response(location, api_key).search("page")[-1].search("table")[0].search("attribute").search("nation").map { |values| values.child.text }
        Hash[keys.zip(values)]
      end

      def home_value(location='chicago', api_key)
        key = parsed_response(location, api_key).search("page").first.search("data").first.search("attribute").first.child.text.downcase
        value = parsed_response(location, api_key).search("page").first.search("data").first.search("nation").first.text
        { key => value }
      end

      def find(location='chicago', api_key)
        attributes = demo_attributes(location, api_key).merge(home_value(location, api_key))
        ZillowApi::National.new(attributes)
      end

      def parsed_response(location='chicago', api_key)
        parse_all(client.get_city_data(location, api_key))
      end

      def parse_all(xml_package)
        Nokogiri::HTML(xml_package)
      end
    end
  end
end