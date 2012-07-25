MyExpenses::Application.routes.draw do

  root :to => 'dashboard#index'

  devise_for :users

  resources :expenses, except: :show
  resources :incomes, except: :show

	#API routes
	namespace :api do
		namespace :v1 do
			resources :tokens, only: [:create]
		end
	end

  get "dashboard/index"
end
