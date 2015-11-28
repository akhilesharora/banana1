require "net/http"
require "uri"
module ArtifactAPI
  class << self
    def artifact_webservice(string_data)
      @encoded_url = URI.encode("https://payumoney.com/getPaymentsSummary?startDate=#{_startdate}&merchantIds=#{_merchantIds}")
      begin
        _uri  = URI.parse(@encoded_url)
        http = Net::HTTP.new(_uri.host, _uri.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(_uri.request_uri)
        response = http.request(request)
        return response.body
      rescue Exception => ex
        # putting a mailer to know error
        #TO DO
        return ex
      end
    end
  end
end