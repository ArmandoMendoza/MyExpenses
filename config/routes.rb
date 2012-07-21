MyExpenses::Application.routes.draw do

  root :to => 'dashboard#index'

  devise_for :users

  resources :expenses, except: :show
  resources :incomes, except: :show

  get "dashboard/index"
end
