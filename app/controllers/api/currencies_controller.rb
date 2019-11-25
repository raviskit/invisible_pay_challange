module Api
  class CurrenciesController < ApplicationController
    # endpoint to convert the source currency into the target currency
    # @param :amount
    #   the value of currency, eg: 10
    # @param :source-currency
    #   the source currency abbreviation, eg: USD, INR, EUR
    # @param :target-currency
    #   the currecy in which source currency gets converted
    #
    # validates all the @params [:amount, :source-currency, :target-currency]
    # @return params can't be empty, please enter amount, source-currency and target-currency if any of the params is empty
    # @return Source currency not supported if source is not a supported currency ( call /api/currency/list to get list of supported currencies)
    # @return Target currency not supported if target is not a supported currency ( call /api/currency/list to get list of supported currencies)
    #
    # @raise StandardError if API call fails
    #
    # @return json: { :converted_amount, :currency }
    def convert
      # Validations
      # Nil conditon checking
      if params[:amount].nil? || params[:'source-currency'].nil? || params[:'target-currency'].nil?
        return render json: "params can't be empty, please enter amount, source-currency and target-currency"
      else
        supported_currencies = JSON.parse(RestClient.get("#{ENV['CURRENCY_CONVERTER_URL']}currencies",
                                                         { params: { apiKey: ENV['CURRENCY_CONVERTER_API_KEY'] } } ))['results']
        if !supported_currencies.keys.include?(params[:'source-currency'].upcase)
          return render json: "Source currency not supported"
        elsif !supported_currencies.keys.include?(params[:'target-currency'].upcase)
          return render json: "Target currency not supported"
        end
      end

      # Logic to get conversion rate from currency converter api
      # @params: :apiKey, :compact, :q
      # @param :compact is optional by recommended as it gives compact result consisting of conversion rate
      # @param :q should be passed in the following format: source-currency_target-currency, eg: USD_INR
      conversion_rate = JSON.parse(RestClient.get("#{ENV['CURRENCY_CONVERTER_URL']}convert",
                                                  { params: {
                                                    apiKey: ENV['CURRENCY_CONVERTER_API_KEY'],
                                                    compact: 'ultra',
                                                    q: "#{params[:'source-currency'].upcase}_#{params[:'target-currency'].upcase}"
                                                  } }
      ))["#{params[:'source-currency'].upcase}_#{params[:'target-currency'].upcase}"]

      render json: { converted_amount: (conversion_rate * params[:amount].to_i), currency: params[:'target-currency'].upcase }
    rescue StandardError => e
      Rails.logger.error "Error while calling the currency conversion API : #{e}"
    end

    # A method to return lists of supported currencies from the currency converter API
    def lists
      lists = JSON.parse(RestClient.get("#{ENV['CURRENCY_CONVERTER_URL']}currencies",
                                        { params: { apiKey: ENV['CURRENCY_CONVERTER_API_KEY'] } } ) )['results']
      render json: lists
    end
  end
end

