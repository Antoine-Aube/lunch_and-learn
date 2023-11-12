class Api::V1::LearningResourcesController < ApplicationController
  def show
    country = params[:country] 
    resource = LearningResourceFacade.get_learning_resource(params[:country])
    render json: LearningResourceSerializer.new(resource)
  end
end
