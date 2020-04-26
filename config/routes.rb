Rails.application.routes.draw do
  resources :jobsmedia
  resources :eventsmedia
  resources :blogsmedia
  resources :items
    scope module: 'api' do
      namespace :v1 do

      #Users resource
        post   '/users/signup'   => 'users#create'
        post   '/users/login'    => 'users#login'
        get    '/users'          => 'users#index'
        get    '/users/current'  => 'users#current'
        patch  '/user/:id'       => 'users#update'
        delete '/user/:id'       => 'users#destroy'
        get    '/user/:id/blogs' => 'users#user_blogs'
        get    '/user/:id/blogger' => 'users#bloggers'
        get    '/user/:id/candidate' => 'users#blogs'

        post 'password/forgot', to: 'passwords#forgot'
        post 'password/reset', to: 'passwords#reset'

      #blogs resource
        get    '/blogs'          => 'blogs#index'
        post   '/blog/post'      => 'blogs#create'
        get    '/blog/:id'       => 'blogs#current'
        patch  '/blog/:id'       => 'blogs#update'
        delete '/blog/:id'       => 'blogs#destroy'
        get    '/blogs/media'    => 'blogsmedia#media'
        post   '/blogs/media/post'  => 'blogsmedia#create'

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
        get    '/candidates'          => 'candidates#index'
        post   '/candidate/post'      => 'candidates#create'
        get    '/candidate/:id'       => 'candidates#current'
        patch  '/candidate/:id'       => 'candidates#update'
        delete '/candidate/:id'       => 'candidates#destroy'
        
      #category resource
        get    '/sectors'          => 'sectors#index'
        post   '/sector/post'      => 'sectors#create'
        get    '/sector/:id'       => 'sectors#current'
        patch  '/sector/:id'       => 'sectors#update'
        delete '/sector/:id'       => 'sectors#destroy'
      #category resource
        get    '/bloggers'          => 'bloggers#index'
        post   '/blogger/post'      => 'bloggers#create'
        get    '/blogger/:id'       => 'bloggers#current'
        patch  '/blogger/:id'       => 'bloggers#update'
        delete '/blogger/:id'       => 'bloggers#destroy'
        
      #events resource
        get    '/events'          => 'events#index'
        post   '/event/post'      => 'events#create'
        get    '/event/:id'       => 'events#current'
        patch  '/event/:id'       => 'events#update'
        delete '/event/:id'       => 'events#destroy'
        get    '/events/media'      => 'eventsmedia#media'
        post    '/events/media/post'      => 'eventsmedia#create'

      #jobs resource
        get    '/jobs'           => 'jobs#index'
        post   '/job/post'       => 'jobs#create'
        get    '/job/:id'        => 'jobs#current'
        patch  '/job/:id'        => 'jobs#update'
        delete '/job/:id'        => 'jobs#destroy'
        get    '/jobs/media'     => 'jobsmedia#media'
        post    '/jobs/media/post'  => 'jobsmedia#create'
        
        
      #Error route
          get '/404', to: 'errors#not_found'
          get '/500', to: 'errors#internal_server_error'
      
        resources :bloggers do
          member do
            get '/profile_pics/:profile_pic', :controller => "bloggers", :action => "profile_pic"
          end
        end
        resources :bloggers do
          member do
            get '/background_pics/:background_pic', :controller => "bloggers", :action => "background_pic"
          end
        end
        resources :candidates do
          member do
            get '/profile_pics/:profile_pic', :controller => "candidates", :action => "profile_pic"
            get '/cover_letters', :controller => "candidates", :action => "cover_letters"
            get '/resumes', :controller => "candidates", :action => "resumes"
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
        resources :jobsmediauploads do
          member do
            get ':file', :controller => "jobsmedia", :action => "file"
          end
        end
        resources :blogsmediauploads do
          member do
            get ':file', :controller => "blogsmedia", :action => "file"
          end
        end
        resources :eventsmediauploads do
          member do
            get ':file', :controller => "eventsmedia", :action => "file"
          end
        end
        
      end
      
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
