Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "posts#index"
  get "/flaka", to: "posts#about", as: "flaka"
  get "/category", to: "posts#category", as: "category"
  get "/contact", to: "posts#contact", as: "contact"
  get "/video", to: "posts#video", as: "video"

end
