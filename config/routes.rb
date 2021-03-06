Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: 'shortened_urls#index'
  get "/:minimized_url", to: "shortened_urls#shortened"
  get "shortened_urls/:minimized_url", to: "shortened_urls#shortened", as: :shortened
  post "/shortened_urls/create"
end
