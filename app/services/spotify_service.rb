# frozen_string_literal: true

class SpotifyService
  attr_accessor :authentication_token

  def initialize(authentication_token)
    @authentication_token = authentication_token
  end

  def get_playlist(music_style)
    @url = full_url(music_style)
    result = request_tracks
    result.body
  end

  def full_url(music_genre)
    "https://api.spotify.com/v1/recommendations?market=BR&seed_artists=4NHQUGzhtTLFvgF5SZesLK&seed_genres=#{music_genre}&seed_tracks=0c6xIDDpzE81m2q797ordA&min_energy=0.4&min_popularity=50"
  end

  def request_tracks
    client = Faraday.new(@url)
    client.authorization :Bearer, @authentication_token
    client.get
  end
end
