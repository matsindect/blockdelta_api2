module Api::V1
        class BlogsController < ApplicationController
            skip_before_action :authenticate_request, only: [:index, :current, :featured_image ]
            before_action :authenticate_user,  only: [ :update]
            before_action :authorize_as_blogger, only: [:create,:destroy]
            before_action :authorize,          only: [:update]
            
        
            # Should work if the current_user is authenticated.
            def index
                @blogs = Blog.filter(params.slice(:sector_id, :title, :user_id,:published)).order('published_at desc')
                render :json => @blogs.to_json(:methods => [ :featured_image])
            rescue ActiveRecord::RecordNotFound
                render json: {}, status: :not_found
            end

            def blog_images
                @blogs = Blog.where(:user_id => current_user.id)
            end
             # Method to create a new @blog using the safe params we setup.
            def create
                @blog = Blog.create(blog_params)
                if params[:published]
                    if current_user && current_user.is_admin?
                        if @blog.save
                            response = { message: 'blog created successfully'}
                            render json: response, status: :created 
                        else
                            render json: @blog.errors, status: :bad
                        end
                    else
                        render json: { error: 'You are not authorized to modify this data'} , status: 401
                    end
                else
                    if @blog.save
                        response = { message: 'blog created successfully'}
                        render json: response, status: :created 
                    else
                        render json: @blog.errors, status: :bad
                    end
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
                if params[:published]
                    if current_user && current_user.is_admin?
                        if @blog.update(blog_params)
                            render json: { status: 200, msg: 'blog details have been updated.' }
                        end
                    else
                        render json: { error: 'You are not authorized to modify this data'} , status: 401
                    end
                else
                    if @blog.update(blog_params)
                        render json: { status: 200, msg: 'blog details have been updated.' }
                    end
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
            # def filtering_params(params)
            #     params.slice(:sector_id, :category_id, :title)
            # end
            # Setting up strict parameters for when we add account creation.
            def media_params
                params.permit(:file => [])
            end
            def blog_params
                params.permit(:title, :description, :slug, :sector_id, :featured_image, :published, :author_name , :author_surname ).merge(user_id: current_user.id)
            end
            # def publish
            #     render json: { error: 'You are not authorized to modify this data'} , status: 401 unless current_user && current_user.is_admin?(params[:id])
            # end
            # Adding a method to check if current_user can update itself. 
            # This uses our blogger method.
            def authorize
                render json: { error: 'You are not authorized to modify this data'} , status: 401 unless current_user && current_user.can_modify_blog?(current_user.id)
            end
        end
end
