Rails.application.routes.draw do
  resources :hotels do
    collection do
      #get 'search/:q', :action => 'search', :as => 'search'
      get 'search'
    end
    resources :reservations
  end

  get '/', to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
