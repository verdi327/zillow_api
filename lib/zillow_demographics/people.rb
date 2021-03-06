require 'nokogiri'

module ZillowApi
  class People
    attr_accessor :single_males, :single_females, :median_age, :average_commute_time,
                  :transportation, :home_value, :who_live_here

    def initialize(attributes)
      self.average_commute_time = attributes['average commute time (minutes)']
      self.single_females       = attributes['single females']
      self.single_males         = attributes['single males']
      self.median_age           = attributes['median age']
      self.who_live_here        = attributes['lives here']
      self.transportation       = attributes['transportation']
      self.home_value           = attributes['zillow home value index']
    end

    class << self

      def client
        ZillowApi::Client.new
      end

      def demo_attributes(location, api_key)
        keys = parsed_response(location, api_key).search("page")[-1].search("table")[0].search("attribute").map {|key| key.child.text.downcase }
        values = parsed_response(location, api_key).search("page")[-1].search("table")[0].search("attribute").search("city").map { |values| values.child.text }
        if values == []
          values = %w[N/A N/A N/A N/A N/A N/A N/A]
        end
        Hash[keys.zip(values)]
      end

      def lives_here_attributes(location, api_key)
        keys = parsed_response(location, api_key).search("page")[-1].search("liveshere").search("title").map { |value| value.text.downcase }
        values = parsed_response(location, api_key).search("page")[-1].search("liveshere").search("name").map { |key| key.text }
        if keys == []
          { 'lives here' => 'N/A'}
        else
          { 'lives here' => Hash[keys.zip(values)] }
        end
      end

      def mode_of_transit(location, api_key)
        key = parsed_response(location, api_key).search("uniqueness").search("category").last.attributes['type'].value.downcase
        value = parsed_response(location, api_key).search("uniqueness").search("category").last.children.map {|s| s.text}
        if key != "transportation"
          { 'transportation' => ["N/A"] }
        else
          { key => value }
        end
      end

      def home_value(location, api_key)
        key = parsed_response(location, api_key).search("page").first.search("data").first.search("attribute").first.child.text.downcase
        value = parsed_response(location, api_key).search("page").first.search("data").first.search("city").first.text
        if value == [] || value.to_i < 25000
          value = ['N/A']
        end
        { key => value }
      end

      def find_by_city(location, api_key)
        attributes = lives_here_attributes(location, api_key).merge(demo_attributes(location, api_key)).merge(home_value(location, api_key)).merge(mode_of_transit(location, api_key))
        ZillowApi::People.new(attributes)
      end

      def parsed_response(location, api_key)
        parse_all(client.get_city_data(location, api_key))
      end

      def parse_all(xml_package)
        Nokogiri::HTML(xml_package)
      end
    end
  end
end