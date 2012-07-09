require 'spec_helper'

describe ZillowApi::Client do
  let(:client) { ZillowApi::Client.new }
  VALID_CITY = ({city: 'chicago', state: 'il'})
  INVALID_CITY = ({city: 'denver'})
  REQUEST = {
             '0' => "Request successfully processed",
             '1' => "Error: missing parameters"
            }

  describe "#get_city_data" do
    context "when given a hash including a valid city and state" do
      it "returns an xml package of data for the specified city" do
        response = Nokogiri::HTML(client.get_city_data(VALID_CITY, ZWSID))
        message = response.search("message").children.first.text
        message.should == REQUEST['0']
      end
    end

    context "when given an invalid hash" do
      it "returns an error message" do
        response = Nokogiri::HTML(client.get_city_data(INVALID_CITY, ZWSID))
        message = response.search("message").children.first.text
        message.should == REQUEST['1']
      end
    end
  end
end