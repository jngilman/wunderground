class HomeController < ApplicationController
  def index


  	@states = %w(HI AK CA OR WA ID UT NV AZ NM CO WY MT ND SD NB KS OK TX LA AR MO IA MN WI IL IN MI OH KY TN MS AL GA FL SC NC VA WV DE MD PA NY NJ CT RI MA VT NH ME DC )
  	@states.sort!
  	if params[:state] != nil && params[:city] != nil
  		params[:city].gsub! " ", "_"
  	response = HTTParty.get("http://api.wunderground.com/api/#{ENV['wunderground_api_key']}/conditions/q/#{params[:state]}/#{params[:city]}.json")["current_observation"]
  	else
  		response = HTTParty.get("http://api.wunderground.com/api/#{ENV['wunderground_api_key']}/conditions/q/FL/Jacksonville.json")["current_observation"]
	end	
  	#location, temp_f, temp_c, weather_icon, weather_word, forecast_link, feels_link
 	@location = response["display_location"]["city"]
 	@temp_f = response["temp_f"]
 	@temp_c = response["temp_c"]
 	@weather_icon = response["icon_url"]
 	@weather_words = response["weather"]
 	@forecast_link = response["forecast_url"]
 	@feels_like = response['feelslike_f']

 	if @weather_words == "Overcast" || @weather_words == "Cloudy"
 		@url = "https://images.unsplash.com/uploads/14125383307942ca04b48/2c169440?crop=entropy&dpr=2&fit=crop&fm=jpg&h=625&ixjsv=2.1.0&ixlib=rb-0.3.5&q=50&w=1325"	
 	elsif @weather_words == "Clear" || @weather_words == "Sunny" || @weather_words == "Mostly Sunny"
 		@url = "https://images.unsplash.com/uploads/141247613151541c06062/c15fb37d?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&w=1080&fit=max&s=d039f37d33cf3cb6929da3ba9c6a41dc"
 			
	end

  end

  def text
  end
end
