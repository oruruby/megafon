Rails.application.routes.draw do

  mount ActionCable.server => '/cable'

  resources :conferences
  resources :conference_actions, only: [:create]

  resources :members
  resources :member_actions, only: [:create]

  post '/megafone', to: 'megafon#callback'
end
