# frozen_string_literal: true

class WeatherService
  attr_accessor :authentication_token

  def initialize(authentication_token)
    @authentication_token = authentication_token
  end

  def get_weather_by_city(city)
    conn = Faraday.new("http://api.openweathermap.org/data/2.5/weather?q=#{city}&&appid=#{@authentication_token}")
    response = conn.get

    weather = JSON.parse(response.body)

    puts weather


    puts weather.class

    weather['main']['temp_min'].to_f
  end
end
