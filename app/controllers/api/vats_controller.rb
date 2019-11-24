module Api
  class VatsController < ApplicationController
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

