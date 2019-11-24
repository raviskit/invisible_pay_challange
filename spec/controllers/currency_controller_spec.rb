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
      allow(RestClient).to receive(:post).and_return('INR_USD': {id: 'INR_USD', val: '0.013929', to: 'USD', fr: 'INR'} )
      post :convert, { params: { amount: 10, 'source-currency': 'INR', 'target-currency': 'USD' } }
      expect(JSON.parse(response.body)['INR_USD']['val']).to eq(0.013929)
    end

  end
end
