MovieRecommendations::Application.routes.draw do
	devise_for :users

	root to: 'home#index'

	resources :recommendations, only: [:index]
	resources :ratings, only: [:index, :create, :update]

	get '/search' => 'ratings#search', as: 'search'
	get '/users/ratings' => 'users#ratings', as: 'user_ratings'

end
