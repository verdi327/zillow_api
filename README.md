# ZillowDemographics

This is a gem for consuming the Zillow Api.  Zillow is an online real estate company that is best known for providing pricing information on homes.  A lesser known service that they provide is demographic information on cities and neighborhoods.  They compile census data with their own internally gathered data to provide statistics like median age of residents for a city, percentage of single male and females, average home size etc...

When creating this gem, I was only concerned with the demographic info Zillow provides.  There is much more to their API, which I hope to cover in the coming months.  To use this gem you will need to first sign up for a api key with Zillow.  That can be found at this link: https://www.zillow.com/webservice/Registration.htm

Use this gem if you need this type of information
+ Percentage of Single Males
+ Percentage of Single Females
+ Median Age
+ Average Commute Time to Work
+ Main Mode of Transportation Within the City
+ Average Home Value
+ Categorization of the Types of People of Live Within the City

## Installation

Add this line to your application's Gemfile:

    gem 'zillow_demographics'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zillow_demographics

## Usage

The gem is structured so that it returns two class types: People and National.
#### People
 Is the local data for the city you are interested in.
#### National
Is the same data, but for the whole US.

Each class has a single method for interacting with the data.
#### class People Example
ZillowApi::People.find_by_city('Chicago', API_KEY) #=> returns an instance of the People class with these attributes:
* single_males (string)
* single_females (string)
* median_age (string)
* average_commute_time (string)
* transportation (array)
* home_value (string)
* who_live_here (hash)

#### class National Example
ZillowApi::People.find(API_KEY) #=> returns an instance of the National class with these attributes:
* single_males (string)
* single_females (string)
* median_age (string)
* average_commute_time (string)
* home_value (string)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
