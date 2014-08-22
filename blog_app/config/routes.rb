Rails.application.routes.draw do


  # get landing page
get '/', to: 'posts#home'

resources :posts


  # get all tags
  get '/tags', to: 'tags#index'

  # show a specific tag with all posts and titles related to
  # each post title should link to the full post 
  get 'tags/:id', to: 'tags#show'

  post '/tags', to: 'tags#index'

end
