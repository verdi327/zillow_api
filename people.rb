require 'nokogiri'

module ZillowApi
  class People
    attr_accessor :single_males, :single_females, :median_age, :average_commute_time, :who_live_here

    def initialize(attributes)
      self.average_commute_time = attributes['average commute time (minutes)']
      self.single_females       = attributes['single females']
      self.single_males         = attributes['single males']
      self.median_age           = attributes['median age']
      self.who_live_here        = attributes['lives here']
    end

    class << self

      def client
        ZillowApi::Client.new
      end

      def data_attributes(location)
        parsed_response = parse_all(client.get_city_data(location))
        keys = parsed_response.search("page")[-1].search("table")[0].search("attribute").map {|key| key.child.text.downcase }
        values = parsed_response.search("page")[-1].search("table")[0].search("attribute").search("city").map { |values| values.child.text }
        Hash[keys.zip(values)]
      end

      def lives_here_attributes(location)
        parsed_response = parse_all(client.get_city_data(location))
        keys = parsed_response.search("page")[-1].search("liveshere").search("title").map { |value| value.text.downcase }
        values = parsed_response.search("page")[-1].search("liveshere").search("name").map { |key| key.text }
        { 'lives here' => Hash[keys.zip(values)] }
      end

      def find_by_city(location)
        attributes = lives_here_attributes(location).merge(data_attributes(location))
        ZillowApi::People.new(attributes)
      end

      def parse_all(xml_package)
        Nokogiri::HTML(xml_package)
      end

    end
  end
end