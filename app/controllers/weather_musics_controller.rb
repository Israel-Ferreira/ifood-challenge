# frozen_string_literal: true

class WeatherMusicsController < ApplicationController
  WS_TOKEN = 'b77e07f479efe92156376a8b07640ced'
  SPOTIFY_TOKEN = 'BQCEnC6lajXxWzpzk8ZBdh1SNCgLoFASsBIFojgp7FPtMfnHOgMtJEC30fS4jwPP4DlhzJRdPu7sPszcum4CbiI1j-jUBe3y97IADDpp9wf6OKu8PJoLwYVBU-ydT8qyfO5uaMMIMxU0DMg'

  def index
    if params[:city]
      temp_celsius = temperature(params[:city])
      puts temp_celsius
      tracks = temperature_track(temp_celsius)
      render json: tracks
    else
      render json: { message: 'Bem vindo ao Weather Music' }
    end
  end

  private

  def to_celsius(tkelvin)
    tkelvin - 273
  end

  def temperature(_city)
    ws = WeatherService.new(WS_TOKEN)
    tkelvin = ws.get_weather_by_city(params[:city])
    to_celsius(tkelvin)
  end

  def temperature_track(temp)
    spotify_service = SpotifyService.new(SPOTIFY_TOKEN)
    if temp > 30
      spotify_service.get_playlist('party')
    elsif temp >= 15 && temp <= 30
      spotify_service.get_playlist('pop')
    elsif temp >= 10 && temp <= 14
      spotify_service.get_playlist('rock')
    else
      spotify_service.get_playlist('classical')
    end
  end
end
