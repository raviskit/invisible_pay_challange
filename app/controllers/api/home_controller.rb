module Api
  class HomeController < ApplicationController
    # Method to return current time
    # @return time in following format: Hours:Minutes:Seconds AM/PM time_zone, eg: 5:30:11 AM +0530
    def current_time
      time = Time.now.strftime("%T %p %z")
      render json: time, status: :ok
    end
  end
end

