require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    url="http://maps.googleapis.com/maps/api/geocode/json?address="+@street_address.downcase.strip.gsub(" ","+")



   parsed_data = JSON.parse(open(url).read)

   latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
   longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

   @lat = latitude
   @lng = longitude

   api_key="6519f6b2b4c0a21742a2f867fc16d9f7"
   url="https://api.darksky.net/forecast/#{api_key}/#{latitude},#{longitude}"

   parsed_data = JSON.parse(open(url).read)

   temperature = parsed_data["currently"]["temperature"]

   summary = parsed_data["currently"]["summary"]

   hourly = parsed_data["minutely"]["summary"]

   several_hours = parsed_data["hourly"]["summary"]

   several_days = parsed_data["daily"]["summary"]


    @current_temperature = temperature

    @current_summary = summary

    @summary_of_next_sixty_minutes = hourly

    @summary_of_next_several_hours = several_hours

    @summary_of_next_several_days = several_days

    render("meteorologist/street_to_weather.html.erb")
  end
end
