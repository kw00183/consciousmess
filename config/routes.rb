Rails.application.routes.draw do
  resources :ripples, except: [:edit, :destroy]
  root :to => 'ripples#index'

  get '/newest' => 'ripples#newest', :as => 'ripples_newest'
  get '/previous' => 'ripples#previous', :as => 'ripples_previous'
  get '/next' => 'ripples#next', :as => 'ripples_next'
  get '/oldest' => 'ripples#oldest', :as => 'ripples_oldest'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
