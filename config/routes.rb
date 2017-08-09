Rails.application.routes.draw do
  root "posts#index"

  devise_for :admins
  mount Ckeditor::Engine => '/ckeditor'

  get "/flaka", to: "posts#about", as: "flaka"
  get "/articulos", to: "posts#articulos", as: "articulos"
  get "/category/:cat_id", to: "posts#articulos", as: "category"
  get "/contact", to: "posts#contact", as: "contact"
  get "/instagram", to: "posts#instagram", as: "instagram"
  get "/video", to: "posts#video", as: "video"
  post "video/add", to: "posts#add_link", as: "add_link"
  delete "video/:id", to: "posts#remove_link", as: "remove_link"
 
  resources :posts

  get "/categories", to: "posts#new", as: "categories"
  post "/categories", to: "posts#create_categories"
  delete "/category/:cat_id", to: "posts#destroy_category", as: "remove_category"
  delete "/delete_img/:url", to: "posts#delete_img", as: "delete_image"

  post "/send", to: "posts#mailer_guest", as: "send"
  post "subscribe", to: "posts#mailer_subscriber", as: "subscribers"
  delete "subscriber/:id", to: "posts#remove_subscriber", as: "remove_subscriber"
end
