# Event hook listener
post 'commits/event', to: 'commits#event'
get 'commits', to: 'commits#index'

# Settings
RedmineApp::Application.routes.draw do
  resources :projects do
    member do
      match 'commit_links_settings', :via => [:get, :post]
    end
  end
end