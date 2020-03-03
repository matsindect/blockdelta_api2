module Api
    module V1
        class BlogsController < ApplicationController
            skip_before_action :authenticate_request, only: [:index, :current]
            before_action :authenticate_user,  only: [ :update]
            before_action :authorize_as_blogger, only: [:create,:destroy]
            before_action :authorize,          only: [:update]
            
        
            # Should work if the current_user is authenticated.
            def index
                @blogs = Blog.all.order("created_at DESC")
                render :json => @blogs.to_json(:methods => [ :featured_image])
            end

             # Method to create a new @blog using the safe params we setup.
            def create
                @blog = Blog.create(blog_params)
                if @blog.save
                    response = { message: 'blog created successfully'}
                    render json: response, status: :created 
                else
                    render json: @blog.errors, status: :bad
                end
            end
            # Method to edit a specific @blog. @blog will need to be authorized.
            def current
                @blog = Blog.find(params[:id])
                render json: @blog
            end
            # Method to update a specific @blog. @blog will need to be authorized.
            def update
                @blog = Blog.find(params[:id])
                if @blog.update(blog_params)
                render json: { status: 200, msg: 'blog details have been updated.' }
                end
            end

            # Method to delete a @blog, this method is only for admin accounts.
            def destroy
                @blog = Blog.find(params[:id])
                if @blog.destroy
                render json: { status: 200, msg: 'User has been deleted.' }
                end
            end

            def featured_image
                @blog = Blog.find(params[:id])
                send_file @blog.featured_image.path, :type => @blog.featured_image_content_type
            end
            private
            # Setting up strict parameters for when we add account creation.
            def blog_params
                params.permit(:title, :description, :sector_id, :category_id).merge(user_id: current_user.id)
            end
            # Adding a method to check if current_user can update itself. 
            # This uses our blogger method.
            def authorize
                render json: { error: 'You are not authorized to modify this data'} , status: 401 unless current_user && current_user.can_modify_blog?(params[:id])
            end
        end
    end
end
