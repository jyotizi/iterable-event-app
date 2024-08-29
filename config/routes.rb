Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :users, controllers: { registrations: 'users/registrations',
                                    sessions:      'users/sessions',
                                    passwords:     'users/passwords' }


  devise_scope :user do
    root to: 'users/sessions#new'
  end

  get '/api/events/:email', to: 'events#index', as: 'events'
  post '/api/events/create_event', to: 'events#create_event'
end
