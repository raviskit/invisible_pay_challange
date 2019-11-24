require 'rails_helper'

RSpec.describe Api::VatsController, type: :controller do
  describe "#validate" do
    it 'returns if not vat code is provided' do
      get :validate
      expect(response.body).to eq('Enter a vatcode')
    end

    it "validates the input VAT and output country code for VAT number" do
      get :validate, { params: { vat_code: 'CZ25123891' } }
      expect(JSON.parse(response.body)['CountryCode']).to eq('CZ')
      expect(JSON.parse(response.body)['VatNumber']).to eq('25123891')
      expect(JSON.parse(response.body)['IsValid']).to eq(true)
    end
  end
end
