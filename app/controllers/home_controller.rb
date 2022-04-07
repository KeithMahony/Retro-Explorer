class HomeController < ApplicationController
  before_action :set_breadcrumbs

  def index
    require 'net/http'
    require 'json'

    # Calling API from AirNow.gov and getting a response
    @output = Locate.runLocator(current_user.try(:location))

    # Check API call is valid / in a relevant location
    if !@output.empty? || !@output
      @aqiOriginal = @output[0]['AQI']
      @aqiTweaked = (@output[0]['AQI']) * 7
      @locationName = @output[0]['ReportingArea']
      @stateName = @output[0]['StateCode']
    else
      @aqiOriginal = "AID cannot get a read from this location."
      @aqiTweaked = "AID cannot get a read from this location."
      @aqiTweakedLabel = "AID cannot get a read from this location."
      @locationName = "Unknown Location"
      @stateName = "Planet e32972"
    end

    @description = "A glowing device in your hand beeps twice. It's display informs you of your geolocation, and what the area was known as before the collapse, " + @locationName + ".
    Below the device's 'AID' label, a pulsing display is home to a barrage of real-time information..."

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
    elsif @aqiTweaked >= 301
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

# Collect cookies containing basic user information
  def set_cookie
    cookies.permanent.signed[:username] = current_user.try(:username)
    cookies.permanent.signed[:email] = current_user.try(:email)
    cookies.permanent.signed[:location] = current_user.try(:location)
  end

  def show_cookie
    @u_name = cookies[:username]
    @e_mail = cookies[:email]
    @u_location = cookies[:location]
  end

  def delete_cookie
    cookies.delete :username
    cookies.delete :email
    cookies.delete :location
  end

  # Keep track of user movement through application
  private
  def set_breadcrumbs
    if session[:breadcrumbs]
      @breadcrumbs = session[:breadcrumbs]
    else
    @breadcrumbs = Array.new
    end

    @breadcrumbs.push(request.url)

    if @breadcrumbs.count > 4
      @breadcrumbs.shift
    end

    session[:breadcrumbs] = @set_breadcrumbs

  end

  def relic
  end

  def userInfo
    @userInfo = form_for(current_user)
  end

end
