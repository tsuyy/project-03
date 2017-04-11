class ForecastsController < ApplicationController

  def get_forecast_by_geolocation

    apikey = '9oGpqA27o7ctsNvzy6IzHwls4XGgIGBq'

    # latitude and longitude
    lat = params[:lat]
    lon = params[:lon]

    # location
    city = HTTParty.get("http://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=#{apikey}&q=#{lat},#{lon}")["SupplementalAdminAreas"][0]['EnglishName']
    state = HTTParty.get("http://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=#{apikey}&q=#{lat},#{lon}")['AdministrativeArea']['ID']
    location_key = HTTParty.get("http://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=#{apikey}&q=#{lat},#{lon}")["Key"]

    # forecasts
    current_condition = HTTParty.get("http://dataservice.accuweather.com/currentconditions/v1/#{location_key}?apikey=#{apikey}")
    daily_forecast = HTTParty.get("http://dataservice.accuweather.com/forecasts/v1/daily/1day/#{location_key}?apikey=#{apikey}&details=true")



    render json: { city: city,
                   state: state,
                   imperial: current_condition[0]["Temperature"]["Imperial"]["Value"],
                   metric: current_condition[0]["Temperature"]["Metric"]["Value"],
                   moon_phase: daily_forecast['DailyForecasts'][0]['Moon']['Phase'],
                   cloud_cover: daily_forecast['DailyForecasts'][0]['Night']['CloudCover']
                 }

  end

  private

    def forecast_params
      params.require(:forcast).permit(:lat, :long, :apikey)
    end

end
