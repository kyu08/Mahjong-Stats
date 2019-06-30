Rails.application.routes.draw do
    get 'signup' => "users#new"
    get "analysis" => "analysis#analysis"
    get "input" => "input#input"
    post "users/:id/update" => "users#update"
    get "users/:id/edit" => "users#edit"
    post "users/create" => "users#create"
    get "users/:id" => "users#show"
    get "signin" => "users#login"
    
    get "/" => "home#top"
    get "about" => "home#about"
end


    # For details on the DSL available within this file, see #http://guides.rubyonrails.org/routing.html
