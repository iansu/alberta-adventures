Rails.application.routes.draw do
  root 'home#index'

  get 'adventures/:id' => 'home#show'
  get 'about' => 'home#about'
end
