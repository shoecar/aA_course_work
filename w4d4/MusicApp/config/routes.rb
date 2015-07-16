Rails.application.routes.draw do
  root to: redirect("/bands")

  resource :users, only: [:create, :new, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :bands do
    resources :albums, only: [:new]
  end
  resources :albums, except: [:new, :index] do
    resources :tracks, only: [:new]
  end
  resources :tracks, except: [:new, :index] do
    resources :notes, only: [:new]
  end
  resources :notes, except: [:new, :inde]

end
