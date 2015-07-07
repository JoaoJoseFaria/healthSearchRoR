class XmlocationsController < ApplicationController
  require 'rest_client'

  API_BASE_URL = "http://healthsearch.azurewebsites.net/HealthSearchRestService.svc/"

  def index
    uri = "#{API_BASE_URL}Localizacao/xml"
    rest_resource = RestClient::Resource.new(uri)
    xmlocations = rest_resource.get
    @xmlocation = Hash.from_xml xmlocations
    @xmlocation = @xmlocation['ArrayOfLocalizacao']['Localizacao']
  end

  def new

  end

  def create
    uri = "#{API_BASE_URL}Localizacao/xml"
    rest_resource = RestClient::Resource.new(uri)
    payload = "<Localizacao xmlns='http://schemas.datacontract.org/2004/07/HealthSearch' xmlns:i='http://www.w3.org/2001/XMLSchema-instance'>"
    payload += "<concelho>#{params[:concelho]}</concelho>"
    payload += "<distrito>#{params[:distrito]}</distrito>"
    payload += "<eliminado i:nil='true'/>"
    payload += "<id>0</id>"
    payload += "<pais>#{params[:pais]}</pais>"
    payload += "<regiao>#{params[:regiao]}</regiao>"
    payload += "</Localizacao>"

    pirulito

    begin
      rest_resource.post payload , :content_type => 'application/xml'
      flash[:notice] = 'Location Saved successfully'
      redirect_to xmlocations_path
    rescue Exception => e
      flash[:error] = 'Location Failed to save'
      redirect_to new_xmlocation_path
    end
  end

  def edit
    uri = "#{API_BASE_URL}Localizacao/#{params[:id]}/xml"
    rest_resource = RestClient::Resource.new(uri)
    xmlocations = rest_resource.get
    @xmlocation = Hash.from_xml xmlocations
  end

  def update
    uri = "#{API_BASE_URL}Localizacao/xml"
    rest_resource = RestClient::Resource.new(uri)
    payload = "<Localizacao xmlns='http://schemas.datacontract.org/2004/07/HealthSearch' xmlns:i='http://www.w3.org/2001/XMLSchema-instance'>"
    payload += "<concelho>#{params[:concelho]}</concelho>"
    payload += "<distrito>#{params[:distrito]}</distrito>"
    payload += "<eliminado i:nil='true'/>"
    payload += "<id>#{params[:id]}</id>"
    payload += "<pais>#{params[:pais]}</pais>"
    payload += "<regiao>#{params[:regiao]}</regiao>"
    payload += "</Localizacao>"
    begin
      rest_resource.put payload , :content_type => "application/xml"
      flash[:notice] = "Location Updated successfully"
    rescue Exception => e
      flash[:error] = "Location Failed to Update"
    end
    redirect_to xmlocations_path
  end

  def xmlocation_params
    params.require(:xmlocation)
        .permit(:id, :pais, :distrito, :regiao, :concelho)
  end
end
