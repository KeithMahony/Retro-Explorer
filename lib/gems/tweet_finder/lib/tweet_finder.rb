class FindTweet
  def self.runSearch(query)

    require 'net/http'
    require 'json'
    require "uri"

    # Create URI
    uri = URI("https://api.twitter.com/2/tweets/search/recent?query=" + query)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    # Attach keys from a verified Twitter Developer Account
    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Bearer AAAAAAAAAAAAAAAAAAAAADehbAEAAAAAWDquQnZpZ0%2Fs4w%2FW4sDMtA6%2FWi8%3DEfSmF2ZVWTIxIsu61Q5XcuNJVLqnozMawpYsoaYBIPbTmhY0sz"
    request["Cookie"] = "guest_id=v1%3A164917039356586617"

    # Parse response as json
    response = https.request(request)
    @collection = JSON.parse(response.body)

    # Get text-only from first (0) entry in returned array (data)
    @tweet1 = @collection["data"][0]["text"]

    return @tweet1

  end

end # End Module
