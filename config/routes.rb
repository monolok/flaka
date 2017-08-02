Rails.application.routes.draw do
  root "posts#index"

  devise_for :admins
  mount Ckeditor::Engine => '/ckeditor'

  get "/flaka", to: "posts#about", as: "flaka"
  get "/articulos", to: "posts#articulos", as: "articulos"
  get "/category/:id", to: "posts#articulos", as: "category"
  get "/contact", to: "posts#contact", as: "contact"
  get "/instagram", to: "posts#instagram", as: "instagram"
  get "/video", to: "posts#video", as: "video"
 
  resources :posts

  get "/categories", to: "posts#new", as: "categories"
  post "/categories", to: "posts#create_categories"
  delete "/category/:id", to: "posts#destroy_category", as: "remove_category"
end
