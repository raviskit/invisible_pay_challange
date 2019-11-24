require 'rails_helper'

RSpec.describe Api::HomeController, type: :controller do
  describe '#current_time' do
    it 'should output the current time' do
      time = Time.now.strftime("%T %p %z")
      get :current_time
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq(time)
    end
  end
end
