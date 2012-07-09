require 'spec_helper'

describe ZillowApi::National do
  let(:chicago_response) { File.open("spec/fixtures/chicago_sample_response.xml") }
  # let(:invalid_response) { File.open("spec/fixtures/invalid_response.xml")}

  context "when receiving an xml response" do
    describe '.parse_all(xml_package)' do
      it 'returns a nokogiri parsed object' do
        ZillowApi::National.parse_all(chicago_response).should be_a(Nokogiri::HTML::Document)
      end
    end

    before(:each) do
      ZillowApi::National.stub(:parsed_response).and_return(Nokogiri::HTML(chicago_response))
    end

    describe '.demo_attributes(location, api_key)' do
      it 'returns a hash of demographic info related to the city' do
        ZillowApi::National.demo_attributes('chicago', ZWSID).should be_a(Hash)
      end

      it 'contains 7 keys' do
        ZillowApi::National.demo_attributes('chicago', ZWSID).keys.count.should == 7
      end

      it 'returns the correct value for median age' do
        ZillowApi::National.demo_attributes('chicago', ZWSID)['median age'].should == "36"
      end
    end

    describe ".home_value(location, api_key)" do
      it 'returns a hash' do
        ZillowApi::National.home_value("chicago", ZWSID).should be_a(Hash)
      end

      it "contains the key 'zillow home value index'" do
        ZillowApi::National.home_value("chicago", ZWSID).keys.should include 'zillow home value index'
      end
    end

    describe ".find_by_city(location, api_key" do
      it "returns an instance of the ZillowApi::People class" do
        ZillowApi::National.find_by_city("chicago", ZWSID).should be_a(ZillowApi::National)
      end
    end
  end
end