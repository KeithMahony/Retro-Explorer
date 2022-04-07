class Locate
  def self.runLocator(location)

    require 'net/http'
    require 'json'

    # Calling API from AirNow.gov and getting a response
    @url = 'https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=' + location.to_s + '&distance=50&API_KEY=28F5C95B-17E7-4E9E-8124-9D6CDA1677FE'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)
    return @output

  end

end # End Module
