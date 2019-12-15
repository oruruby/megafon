Rails.application.routes.draw do

  mount ActionCable.server => '/cable'

  resources :conferences
  resources :conference_actions, only: %i{create}

  resources :members, only: %i{ create index }

  post '/megafone', to: 'megafon#callback'
end
