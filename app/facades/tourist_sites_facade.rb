class TouristSitesFacade
  def self.get_tourist_sites(country)
    coordinates = get_capital_coordinates(country)
    response = places_service(coordinates)
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
    response = country_service(country)
    response_body = parse_json(response)
    country_info = response_body.first
    country_info[:capitalInfo].empty? ? [0,0] : country_info[:capitalInfo][:latlng]
  end

  def self.places_service(coordinates)
    PlacesService.new.get_tourist_sites(coordinates)
  end

  def self.country_service(country)
    CountryService.new.capital_coordinates(country)
  end

  private

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end