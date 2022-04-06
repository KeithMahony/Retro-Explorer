class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'
    # Calling API from AirNow.gov and getting a response
    @url = 'https://www.airnowapi.org/aq/observation/latLong/current/?format=application/json
    &latitude=36.1088&longitude=-115.0595&distance=50&API_KEY=28F5C95B-17E7-4E9E-8124-9D6CDA1677FE'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)
    # Check API call is valid
    if @output.empty? || !@output
      @aqiOriginal = "AID cannot get a read from this location."
      @aqiTweaked = "AID cannot get a read from this location."
      @locationName = "Unknown Location"
      @stateName = "Planet e32972"
    else
      @aqiOriginal = @output[0]['AQI']
      @aqiTweaked = (@output[0]['AQI']) + 150
      @locationName = @output[0]['ReportingArea']
      @stateName = @output[0]['StateCode']
    end
#  Adjust background colour and flavour text based on Air Quality API response
#  Tweaked adjustments
    if @aqiTweaked == "AID cannot get a read from this location."
      @apiColour = "gray"
    elsif @aqiTweaked <= 50
      @apiColour = "green"
      @aqiTweakedLabel = "Good - Air quality is satisfactory, and air pollution poses
      little or no risk."
    elsif @aqiTweaked >= 51 && @aqiTweaked <= 100
      @apiColour = "yellow"
      @aqiTweakedLabel = "Moderate - Air quality is acceptable. However, there may be a risk
       for some people, particularly those who are unusually sensitive to air pollution."
    elsif @aqiTweaked >= 101 && @aqiTweaked <= 150
      @apiColour = "orange"
      @aqiTweakedLabel = "USG - Members of sensitive groups may experience health effects. The general public is less likely to be affected."
    elsif @aqiTweaked >= 151 && @aqiTweaked <= 200
      @apiColour = "red"
      @aqiTweakedLabel = "Members of the general public may experience health effects."
    elsif @aqiTweaked >= 201 && @aqiTweaked <= 300
      @apiColour = "purple"
      @aqiTweakedLabel = "Health alert - The risk of health effects is increased for everyone in this area."
    elsif @aqiTweaked >= 301 && @aqiTweaked <= 500
      @apiColour = "maroon"
      @aqiTweakedLabel = "Health warning of emergency conditions - everyone likely to be affected by conditions in this area."
    end
#  Original adjustments
    if @aqiOriginal == "AID cannot get a read from this location."
    elsif @aqiOriginal <= 50
      @aqiOriginalLabel = "Good - Air quality is satisfactory, and air pollution poses
      little or no risk."
    elsif @aqiOriginal >= 51 && @aqiOriginal <= 100
      @aqiOriginalLabel = "Moderate - Air quality is acceptable. However, there may be a risk
       for some people, particularly those who are unusually sensitive to air pollution."
    elsif @aqiOriginal >= 101 && @aqiOriginal <= 150
      @aqiOriginalLabel = "USG - Members of sensitive groups may experience health effects. The general public is less likely to be affected."
    elsif @aqiOriginal >= 151 && @aqiOriginal <= 200
      @aqiOriginalLabel = "Unhealthy - Members of the general public may experience health effects; members of sensitive groups may experience more serious health effects."
    elsif @aqiOriginal >= 201 && @aqiOriginal <= 300
      @aqiOriginalLabel = "Health alert - The risk of health effects is increased for everyone in this area."
    elsif @aqiOriginal >= 301 && @aqiOriginal <= 500
      @aqiOriginalLabel = "Health warning of emergency conditions - everyone likely to be affected by conditions in this area."
    end
  end

def relic
end

def userInfo
  @userInfo = form_for(current_user)
end


end
