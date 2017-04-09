class WeatherSearch

  attr_accessor :get_location, :daily_forecast, :current_condition, :current_temp, :astro_forecast, :search
  include HTTParty

  base_uri 'http://dataservice.accuweather.com'
  # default_params fields: apikey: '9oGpqA27o7ctsNvzy6IzHwls4XGgIGBq' q: 'search'

  def initialize(search = 'honolulu')
    get_location(search)
    current_condition
    daily_forecast
    current_temp
    astro_forecast
  end

  def get_location(search)
    @get_location = HTTParty.get("http://dataservice.accuweather.com/locations/v1/search?apikey=9oGpqA27o7ctsNvzy6IzHwls4XGgIGBq&q=#{search}")
    @location_key = @get_location[0]['Key']
  end

  def current_condition
    @current_condition = HTTParty.get("http://dataservice.accuweather.com//currentconditions/v1/#{@location_key}?apikey=9oGpqA27o7ctsNvzy6IzHwls4XGgIGBq")
  end

  def daily_forecast
    @daily_forecast = HTTParty.get("http://dataservice.accuweather.com/forecasts/v1/daily/1day/#{@location_key}?apikey=9oGpqA27o7ctsNvzy6IzHwls4XGgIGBq&details=true")
  end

  # retrieves current temperature
  def current_temp
    p @current_condition[0]["Temperature"]["Metric"]["Value"]
    p @current_condition[0]["Temperature"]["Imperial"]["Value"]
  end

  # retrieves today's moon phase and cloud cover at night
  def astro_forecast
    p @daily_forecast['DailyForecasts'][0]['Moon']['Phase']
    p @daily_forecast['DailyForecasts'][0]['Night']['CloudCover']
  end

  # @get_geolocation = HTTParty.get("http://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=9oGpqA27o7ctsNvzy6IzHwls4XGgIGBq&q=#{geolocation}")

end
