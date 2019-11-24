Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: 'json' } do
    get :current_time, to: 'home#current_time'

    resource :currency do
      get :convert
      get :lists
    end

    resource :vat do
      get :validate
    end
  end
end
