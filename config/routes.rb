Rails.application.routes.draw do
  get "courses/new_release" => "courses#new_release", :as => :new_release
  get "sessions/new"
  get "static_pages/home"
  get "static_pages/help"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users do
    member do
      get :all_joined_courses
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :courses do
    member do
      get :words_of_course, :learn, :examination, :check_answer
    end
  end
  resources :categories, only: [:new, :create]
  resources :results, only: [:create, :destroy]
  resources :words do
    collection do #collection lay ra 1 tap words , va k can truyen id
      get :search_word
    end
  end
end
