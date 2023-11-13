class TouristSitesFacade
  def self.get_tourist_sites(country)
    coordinates = get_capital_coordinates(country)
    response = PlacesService.new.get_tourist_sites(coordinates)
    response_body = parse_json(response)
    if response_body[:features].empty?
      return nil
    else
      response_body[:features].map do |tourist_site_data|
        TouristSite.new(tourist_site_data)
      end
    end
  end

  def self.get_capital_coordinates(country)
    response = CountryService.new.capital_coordinates(country)
    response_body = parse_json(response)
    country_info = response_body.first
    if country_info[:capitalInfo].empty?
      [0,0]
    else 
      country_info[:capitalInfo][:latlng]
    end
  end

  private

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end