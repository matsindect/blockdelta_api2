Rails.application.routes.draw do
  constraints subdomain: 'api' do
    scope module: 'api' do
      namespace :v1 do

      #Users resource
        post   '/users/signup'   => 'users#create'
        post   '/users/login'    => 'users#login'
        get    '/users'          => 'users#index'
        get    '/users/current'  => 'users#current'
        patch  '/user/:id'       => 'users#update'
        delete '/user/:id'       => 'users#destroy'

        post 'password/forgot', to: 'passwords#forgot'
        post 'password/reset', to: 'passwords#reset'

      #blogs resource
        get    '/blogs'          => 'blogs#index'
        post   '/blog/post'      => 'blogs#create'
        get    '/blog/current'   => 'blogs#current'
        patch  '/blog/:id'       => 'blogs#update'
        delete '/blog/:id'       => 'blogs#destroy'

      #category resource
        get    '/categories'         => 'categories#index'
        post   '/category/post'      => 'categories#create'
        get    '/category/:id'       => 'categories#current'
        patch  '/category/:id'       => 'categories#update'
        delete '/category/:id'       => 'categories#destroy'

      #category resource
        get    '/profiles'          => 'profiles#index'
        post   '/profile/post'      => 'profiles#create'
        get    '/profile/:id'       => 'profiles#current'
        patch  '/profile/:id'       => 'profiles#update'
        delete '/profile/:id'       => 'profiles#destroy'
        
      #category resource
        get    '/sectors'          => 'sectors#index'
        post   '/sector/post'      => 'sectors#create'
        get    '/sector/:id'       => 'sectors#current'
        patch  '/sector/:id'       => 'sectors#update'
        delete '/sector/:id'       => 'sectors#destroy'
      #category resource
        get    '/bloggers'           => 'bloggers#index'
        post   '/blogger/post'      => 'bloggers#create'
        get    '/blogger/:id'       => 'bloggers#current'
        patch  '/blogger/:id'       => 'bloggers#update'
        delete '/blogger/:id'       => 'bloggers#destroy'
        

        resources :bloggers do
          member do
            get ':profile_pic', :controller => "bloggers", :action => "profile_pic"
          end
        end
        resources :candidates do
          member do
            get ':profile_pic', :controller => "candidates", :action => "profile_pic"
          end
        end
        resources :blogs do
          member do
            get ':featured_image', :controller => "blogs", :action => "featured_image"
          end
        end
        resources :events do
          member do
            get ':featured_image', :controller => "events", :action => "featured_image"
          end
        end
      end
      
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
