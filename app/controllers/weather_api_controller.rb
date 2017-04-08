class WeatherApiController < ApplicationController
  attr_accessor :get_location, :daily_forecast, :current_condition
  include HTTParty

  base_uri 'http://dataservice.accuweather.com'
  # default_params fields: apikey: '9oGpqA27o7ctsNvzy6IzHwls4XGgIGBq', q: 'search'

  def initialize()
    @get_geolocation = HTTParty.get("http://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=9oGpqA27o7ctsNvzy6IzHwls4XGgIGBq&q=#{geolocation}")
    @get_location = HTTParty.get("http://dataservice.accuweather.com/locations/v1/search?apikey=9oGpqA27o7ctsNvzy6IzHwls4XGgIGBq&q=taipei")
    key = @get_location[0]['Key']
    @current_condition = HTTParty.get("http://dataservice.accuweather.com//currentconditions/v1/#{key}?apikey=9oGpqA27o7ctsNvzy6IzHwls4XGgIGBq")
    @daily_forecast = HTTParty.get("http://dataservice.accuweather.com/forecasts/v1/daily/1day/#{key}?apikey=9oGpqA27o7ctsNvzy6IzHwls4XGgIGBq&details=true")
  end

end
