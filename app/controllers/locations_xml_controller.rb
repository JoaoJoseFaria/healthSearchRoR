class LocationsXmlController < ApplicationController
  require 'rest_client'

  API_BASE_URL = "http://healthsearch.azurewebsites.net/HealthSearchRestService.svc/"

  def index
    uri = "#{API_BASE_URL}Localizacao/xml"
    rest_resource = RestClient::Resource.new(uri)
    locations_xml = rest_resource.get
    @location_xml = Hash.from_xml(locations_xml)
  end

  def new

  end

  def create
    uri = "#{API_BASE_URL}Localizacao/xml"
    payload = params.to_xml
    rest_resource = RestClient::Resource.new(uri)
    begin
      rest_resource.post payload , :content_type => 'application/xml'
      flash[:notice] = 'Location Saved successfully'
      redirect_to locations_xml_path
    rescue Exception => e
      flash[:error] = 'Location Failed to save'
      render :new
    end
  end

  def edit
    uri = "#{API_BASE_URL}Localizacao/#{params[:id]}/xml"
    rest_resource = RestClient::Resource.new(uri)
    locations_xml = rest_resource.get
    @location_xml = Hash.from_xml(locations_xml, :symbolize_names => true)
  end

  def update
    uri = "#{API_BASE_URL}Localizacao/xml"
    payload = params.to_xml
    rest_resource = RestClient::Resource.new(uri)
    begin
      rest_resource.put payload , :content_type => "application/xml"
      flash[:notice] = "Location Updated successfully"
    rescue Exception => e
      flash[:error] = "Location Failed to Update"
    end
    redirect_to locations_xml_path
  end

  def destroy
    uri = "#{API_BASE_URL}Localizacao/#{params[:id]}/xml"
    rest_resource = RestClient::Resource.new(uri)
    begin
      rest_resource.delete
      flash[:notice] = 'Location Deleted successfully'
    rescue Exception => e
      flash[:error] = 'Location Failed to Delete'
    end
    redirect_to locations_xml_path
  end

  private

  def location_xml_params
    params.require(:location)
        .permit(:id, :pais, :distrito, :regiao, :concelho)
  end
end
