module Api
  class HomeController < ApplicationController
    def current_time
      time = Time.now.strftime("%T %p %z")
      render json: time, status: :ok
    end
  end
end

