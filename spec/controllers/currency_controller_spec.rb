require 'rails_helper'

RSpec.describe Api::CurrenciesController, type: :controller do
  describe '#convert' do
    context 'validation' do
      it 'validates the input field when all params are missing' do
        post :convert
        expect(response.body).to eq("params can't be empty, please enter amount, source-currency and target-currency")
      end

      it 'validates the input field when source params are missing' do
        post :convert, { params: { amount: 10, 'target-currency': 'USD' } }
        expect(response.body).to eq("params can't be empty, please enter amount, source-currency and target-currency")
      end

      it 'validates the input field when target params are missing' do
        post :convert, { params: { amount: 10, 'source-currency': 'USD' } }
        expect(response.body).to eq("params can't be empty, please enter amount, source-currency and target-currency")
      end
    end

    it 'converts the currency and output the result' do
      allow(RestClient).to receive(:post).and_return('INR_USD': '0.13936')
      post :convert, { params: { amount: 10, 'source-currency': 'INR', 'target-currency': 'USD' } }
      expect(JSON.parse(response.body)['converted_amount']).to eq(0.13936)
      expect(JSON.parse(response.body)['currency']).to eq('USD')
    end

  end
end
