require "sinatra"
require "sinatra/reloader"
require "http"
require "dotenv/load"

get("/") do
  @raw_response = HTTP.get("https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}")

  @string_response = @raw_response.to_s
  @parsed_response = JSON.parse(@string_response)

  @currencies = @parsed_response.fetch("currencies").keys
  erb(:homepage)
end


get("/:from_currency") do
@the_symbol = params.fetch("from_currency")
@raw_response = HTTP.get("https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}")

@string_response = @raw_response.to_s
@parsed_response = JSON.parse(@string_response)

@currencies = @parsed_response.fetch("currencies").keys

erb(:step_one)
end


get("/:from_currency/:to_currency") do
  @from = params.fetch("from_currecy")
  @to = params.fetch("to_currecy")

  @the_symbol = params.fetch("from_currency")
@raw_response = HTTP.get("https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}")

@string_response = @raw_response.to_s
@parsed_response = JSON.parse(@string_response)

@currencies = @parsed_response.fetch("currencies").keys

  erb(:step_two)
  end
