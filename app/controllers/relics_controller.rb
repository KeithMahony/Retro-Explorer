require 'json'
require "uri"
require "net/http"

class RelicsController < ApplicationController
  before_action :set_relic, only: %i[ show edit update destroy ]
  # kick user to home screen if not signed in
  before_action :authenticate_user!, except: [:index]
  # prevent user finding workarounds client side
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /relics or /relics.json
  def index
    @relics = Relic.all
  end

  # GET /relics/1 or /relics/1.json
  def show
  end

  # Updated method to generate relic output and associate relics with a user
  # GET /relics/new
  def new
    # @relic = Relic.new
    @relic = current_user.relics.build

    # Air Now API
    @url = 'https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=' + current_user.try(:location).to_s + '&distance=50&API_KEY=28F5C95B-17E7-4E9E-8124-9D6CDA1677FE'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)

    # Check API call is valid
    # Update Twitter API call
    if @output.empty? || !@output
      @aqiOriginal = "AID cannot get a read from this location."
      @aqiTweaked = "AID cannot get a read from this location."
      @aqiTweakedLabel = "AID cannot get a read from this location."
      @locationName = "Unknown Location"
      @stateName = "Planet e32972"
      url = URI("https://api.twitter.com/2/tweets/search/recent?query=world ending")
    else
      @aqiOriginal = @output[0]['AQI']
      @aqiTweaked = (@output[0]['AQI']) *10
      @locationName = @output[0]['ReportingArea']
      @stateName = @output[0]['StateCode']
      url = URI("https://api.twitter.com/2/tweets/search/recent?query=" + @locationName)
    end

    # client = Twitter::REST::Client.new do |config|
    # config.consumer_key        = "q6smznXFNdlfqHqLl9ir7YlSi"
    # config.consumer_secret     = "EoxUjend1R86u8ImdMcvMQF2hN95xl3MUHY4loor9W6usLF5Mu"
    # # config.access_token        = "YOUR_ACCESS_TOKEN"
    # # config.access_token_secret = "YOUR_ACCESS_SECRET"
    # end

    # Set Relic Device Name
    @relicName = "Glass-Faced Device"

    # Set Relic Output
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["Authorization"] = "Bearer AAAAAAAAAAAAAAAAAAAAADehbAEAAAAAWDquQnZpZ0%2Fs4w%2FW4sDMtA6%2FWi8%3DEfSmF2ZVWTIxIsu61Q5XcuNJVLqnozMawpYsoaYBIPbTmhY0sz"
    request["Cookie"] = "guest_id=v1%3A164917039356586617"

    response = https.request(request)
    @collection = JSON.parse(response.body)
    @tweet1 = @collection["data"][0]["text"]

  end

  # GET /relics/1/edit
  def edit
  end

  # Updated method to associate relics with a user
  # POST /relics or /relics.json
  def create
    # @relic = Relic.new(relic_params)
    # @relic = current_user.relics.build(params[:relic]) <--- Come back to this to have User IDs display as usernames
    @relic = current_user.relics.build(relic_params)

    respond_to do |format|
      if @relic.save
        format.html { redirect_to relic_url(@relic), notice: "Relic was successfully collected." }
        format.json { render :show, status: :created, location: @relic }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @relic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /relics/1 or /relics/1.json
  def update
    respond_to do |format|
      if @relic.update(relic_params)
        format.html { redirect_to relic_url(@relic), notice: "Relic was successfully updated." }
        format.json { render :show, status: :ok, location: @relic }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @relic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /relics/1 or /relics/1.json
  def destroy
    @relic.destroy

    respond_to do |format|
      format.html { redirect_to relics_url, notice: "Relic was successfully discarded." }
      format.json { head :no_content }
    end
  end

# prevent editing of relics by anyone but original owner
  def correct_user
    @relic = current_user.relics.find_by(id: params[:id])
    redirect_to relics_path, notice: "That relic was collected by someone else." if @relic.nil?
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_relic
      @relic = Relic.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def relic_params
      params.require(:relic).permit(:device_name, :device_output, :user_id)
    end
end
