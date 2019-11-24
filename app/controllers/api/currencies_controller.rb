require 'errors/errors'
module Api
  class CurrenciesController < ApplicationController
    def convert
      if params[:amount].nil? || params[:'source-currency'].nil? || params[:'target-currency'].nil?
        return render json: "params can't be empty, please enter amount, source-currency and target-currency"
      else
        supported_currencies = JSON.parse(RestClient.get("#{ENV['CURRENCY_CONVERTER_URL']}currencies", { params: { apiKey: ENV['CURRENCY_CONVERTER_API_KEY'] } } ))['results']
        if !supported_currencies.keys.include?(params[:'source-currency'].upcase)
          return render json: "Source currency not supported"
        elsif !supported_currencies.keys.include?(params[:'target-currency'].upcase)
          return render json: "Target currency not supported"
        end
      end

      converted_amount = JSON.parse(RestClient.get("#{ENV['CURRENCY_CONVERTER_URL']}convert", { params: { apiKey: ENV['CURRENCY_CONVERTER_API_KEY'], q: "#{params[:'source-currency'].upcase}_#{params[:'target-currency'].upcase}" } } ) )['results']
      render json: converted_amount
    end

    def lists
      lists = JSON.parse(RestClient.get("#{ENV['CURRENCY_CONVERTER_URL']}currencies", { params: { apiKey: ENV['CURRENCY_CONVERTER_API_KEY'] } } ) )['results']
      render json: lists
    end
  end
end

