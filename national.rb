require 'nokogiri'

module ZillowApi
  class National
    attr_accessor :single_males, :single_females, :median_age, :average_commute_time

    def initialize(attributes)
      self.average_commute_time = attributes['average commute time (minutes)']
      self.single_females       = attributes['single females']
      self.single_males         = attributes['single males']
      self.median_age           = attributes['median age']
    end

    class << self

      def client
        ZillowApi::Client.new
      end

      def data_attributes(location)
        parsed_response = parse_all(client.get_city_data(location))
        keys = parsed_response.search("page")[-1].search("table")[0].search("attribute").map {|key| key.child.text.downcase }
        values = parsed_response.search("page")[-1].search("table")[0].search("attribute").search("nation").map { |values| values.child.text }
        Hash[keys.zip(values)]
      end

      def find_by_city(location)
        ZillowApi::National.new(data_attributes(location))
      end

      def parse_all(xml_package)
        Nokogiri::HTML(xml_package)
      end

    end
  end
end