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
end
