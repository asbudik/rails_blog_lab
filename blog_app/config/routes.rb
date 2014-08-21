Rails.application.routes.draw do

  # get landing page
  get '/', to: 'posts#home'

  # get all posts
  get '/posts', to: 'posts#index'

  # get new post form
  get 'posts/new', to: 'posts#new'

  # get the show page for specific post
  get '/posts/:id', to: 'posts#show'

  # post a new post to create, redirect to /posts
  post '/posts', to: 'posts#create'
  
  # get all tags
  get '/tags', to: 'tags#index'

  # show a specific tag with all posts and titles related to
  # each post title should link to the full post 
  get 'tags/:id', to: 'tags#show'

  post '/tags', to: 'tags#index'




  get 'posts/:id/edit', to: 'posts#edit'




  put '/posts', to: 'posts#update'

  delete '/posts/:id', to: 'posts#destroy'
end
