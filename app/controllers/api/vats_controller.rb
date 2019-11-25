module Api
  class VatsController < ApplicationController
    # Method to validate input vatcode
    # @params :vat_code
    #   VatCode is unique code representing a VAT Number. eg: CZ25123891
    # @return "Enter a vatcode" if no vat_code is passed.
    # @return a hash containing following params: [ :CountryCode, :VatNumber, :IsValid, :BusinessName, :BusinessAddress]
    #
    # @raise CloudmersiveValidateApiClient::ApiError if API call fails
    def validate
      return render json: "Enter a vatcode" if params[:vat_code].nil?
      api_instance = CloudmersiveValidateApiClient::VatApi.new
      input = CloudmersiveValidateApiClient::VatLookupRequest.new(VatCode: params[:vat_code])

      begin
        #Lookup a VAT code
        result = api_instance.vat_vat_lookup(input)
        render json: result
      rescue CloudmersiveValidateApiClient::ApiError => e
        Rails.logger.error "Exception when calling VatApi->vat_vat_lookup: #{e}"
      end
    end
  end
end

