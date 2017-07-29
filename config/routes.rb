Rails.application.routes.draw do
  root "posts#index"

  devise_for :admins
  mount Ckeditor::Engine => '/ckeditor'

  get "/flaka", to: "posts#about", as: "flaka"
  get "/category", to: "posts#category", as: "category"
  get "/contact", to: "posts#contact", as: "contact"
  get "/instagram", to: "posts#instagram", as: "instagram"
  get "/video", to: "posts#video", as: "video"
 
  resources :posts

end
