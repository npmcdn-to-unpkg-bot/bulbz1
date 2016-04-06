require "net/http"
require "uri"
require 'json'

class Comment < ActiveRecord::Base
  belongs_to :bulb
  belongs_to :user

  def keyword_generator
    uri = URI.parse("https://api.monkeylearn.com/v2/extractors/ex_y7BPYzNG/extract/")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri)
    # Set POST data
    request.body = {text_list: [self.content]}.to_json
    request.add_field("Content-Type", "application/json")
    request.add_field("Authorization", "token c956c6be34d90185c5eab3c04a8f58416259aa67")
    # parse the monkeylearn respons
    response = JSON.parse http.request(request).body
    response_array = response["result"].first

    keywords = Array.new

    response_array.each do |response|
      keywords << response["keyword"]
    end

    bulb = Bulb.find_by(:id => self.bulb_id)

    keywords.each do |keyword|
      k = Keyword.new
      k.bulb_id = bulb.id
      k.content = keyword
      k.save
    end

  end

end
