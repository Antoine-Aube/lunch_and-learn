class CountryFacade
  def self.sample_country
    response = CountryService.new.sample_country
    response_body = JSON.parse(response.body, symbolize_names: true)
    response_body.map do |country_data|
      # require 'pry';binding.pry
      Country.new(country_data)
    end
  end
end