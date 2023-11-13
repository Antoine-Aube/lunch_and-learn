class Api::V1::TouristSitesController < ApplicationController
  def index
    tourist_sites = TouristSitesFacade.get_tourist_sites(params[:country])
    if tourist_sites != nil
      render json: TouristSiteSerializer.new(tourist_sites)
    else
      render json: {data: []}, status: 404
    end 
  end
end