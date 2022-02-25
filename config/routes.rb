Rails.application.routes.draw do
  resources :ripples, except: [:edit, :destroy]
  root :to => 'ripples#index'

  get 'ripple/newest', 'ripple#newest'
  get 'ripple/previous', 'ripple#previous'
  get 'ripple/next', 'ripple#next'
  get 'ripple/oldest', 'ripple#oldest'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
