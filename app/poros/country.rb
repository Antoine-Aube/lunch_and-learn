class Country
  attr_reader :id, :name

  def initialize(country_data)
    @name = country_data[:name][:common]
  end
end