# Prefix Verb   URI Pattern                                Controller#Action
#   cats    GET    /cats(.:format)                            cats#index
#           POST   /cats(.:format)                            cats#create
# new_cat   GET    /cats/new(.:format)                        cats#new
# edit_cat  GET    /cats/:id/edit(.:format)                   cats#edit
#    cat    GET    /cats/:id(.:format)                        cats#show
#           PATCH  /cats/:id(.:format)                        cats#update
#           PUT    /cats/:id(.:format)                        cats#update
# approve_cat_rental_request  POST   /cat_rental_requests/:id/approve(.:format) cat_rental_requests#approve
# deny_cat_rental_request     POST   /cat_rental_requests/:id/deny(.:format)    cat_rental_requests#deny
# cat_rental_requests         POST   /cat_rental_requests(.:format)             cat_rental_requests#create
# new_cat_rental_request      GET    /cat_rental_requests/new(.:format)         cat_rental_requests#new

#  users    POST   /users(.:format)                           users#create
# new_user  GET    /users/new(.:format)                       users#new

# session   POST   /session(.:format)                         sessions#create
# new_session GET    /session/new(.:format)                     sessions#new
#           DELETE /session(.:format)                         sessions#destroy
#   root    GET    /                                          redirect(301, /cats)

NinetyNineCatsDay1::Application.routes.draw do
  resources :cats, except: :destroy
  resources :cat_rental_requests, only: [:create, :new] do
    post "approve", on: :member
    post "deny", on: :member
  end
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]

  root to: redirect("/cats")
end
