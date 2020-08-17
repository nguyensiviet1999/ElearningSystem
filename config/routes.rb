Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    get "join_rooms/create"
    get "join_rooms/destroy"
    get "messages/create"
    get "messages/show"
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
    get "auth/google_oauth2/callback", to: "sessions#create_with_gmail"
    get "auth/facebook/callback", to: "sessions#create_with_facebook"
    get "auth/failure", to: redirect("/")

    resources :users do
      member do
        get :all_joined_courses, :following, :followers
      end
    end
    resources :account_activations, only: [:edit]
    resources :password_resets, only: [:new, :create, :edit, :update]
    resources :courses do
      member do
        get :learn, :examination, :check_answer
      end
      resources :course_words do
        collection do
          get :delete
        end
      end
    end
    resources :categories, only: [:new, :create]
    resources :results, only: [:create, :destroy]
    resources :course_words, only: [:new, :create, :delete, :destroy]
    resources :words do
      collection do #collection lay ra 1 tap words , va k can truyen id
        get :search_word
        post :get_data_from_file
      end
    end
    resources :relationships, only: [:create, :destroy]
    resources :user_learned_words, only: [:create, :destroy]
    # Serve websocket cable requests in-process
    mount ActionCable.server => "/cable"
    resources :chatrooms do
      member do
        get :start, :ready, :join_chatroom, :render_match, :finished, :check_room_status
      end
    end
    resources :messages
  end
end
