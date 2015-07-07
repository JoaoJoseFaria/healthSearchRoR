class LocationsController < ApplicationController
  require 'rest_client'

  API_BASE_URL = "http://healthsearch.azurewebsites.net/HealthSearchRestService.svc/"

  def index
    uri = "#{API_BASE_URL}Localizacao/json"
    rest_resource = RestClient::Resource.new(uri)
    locations = rest_resource.get
    @location = JSON.parse(locations, :symbolize_names => true)
  end

  def new

  end

  def create
    uri = "#{API_BASE_URL}Localizacao/json"
    payload = params.to_json
    rest_resource = RestClient::Resource.new(uri)
    begin
      rest_resource.post payload , :content_type => 'application/json'
      flash[:notice] = 'Location Saved successfully'
      redirect_to locations_path
    rescue Exception => e
      flash[:error] = 'Location Failed to save'
      redirect_to new_location_path
    end
  end

  def edit
    uri = "#{API_BASE_URL}Localizacao/#{params[:id]}/json"
    rest_resource = RestClient::Resource.new(uri)
    locations = rest_resource.get
    @location = JSON.parse(locations, :symbolize_names => true)
  end

  def update
    uri = "#{API_BASE_URL}Localizacao/json"
    payload = params.to_json
    rest_resource = RestClient::Resource.new(uri)
    begin
      rest_resource.put payload , :content_type => "application/json"
      flash[:notice] = "Location Updated successfully"
    rescue Exception => e
      flash[:error] = "Location Failed to Update"
    end
    redirect_to locations_path
  end

  def destroy
    uri = "#{API_BASE_URL}Localizacao/#{params[:id]}/json"
    rest_resource = RestClient::Resource.new(uri)
    begin
      rest_resource.delete
      flash[:notice] = 'Location Deleted successfully'
    rescue Exception => e
      flash[:error] = 'Location Failed to Delete'
    end
    redirect_to locations_path
  end

  private

  def location_params
    params.require(:location)
        .permit(:id, :pais, :distrito, :regiao, :concelho)
  end

end
