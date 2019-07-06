Rails.application.routes.draw do

    get "login" => "users#login_form"
    post "login" => "users#login"
    get "logout" => "users#logout"
    get 'signup' => "users#new"
    get "input" => "input#input"
    post "users/:id/update" => "users#update"
    get "users/:id/edit" => "users#edit"
    post "users/create" => "users#create"
    get "users/:id" => "users#show"
    get "date/input" => "round#input"
    post "date/create" => "round#create"
    get "date/analysis" => "round#analysis"

    
    get "/" => "home#top"
    get "about" => "home#about"
end


    # For details on the DSL available within this file, see #http://guides.rubyonrails.org/routing.html
