module Api::V1
        class BloggersController < ApplicationController
            before_action :authenticate_user,  only: [ :index, :update, :current, :profile_pic, :background_pic]
            before_action :authorize_as_blogger, only: [:create,:destroy, :current]
            before_action :find_blogger, only: [:update, :destroy, :current, :authorize]
            before_action :authorize,          only: [ :update, :current, :destroy]
            
        
            # Should work if the current_user is authenticated.
            def index
                @blogger = Blogger.filter(params.slice(:user_id))
                render :json => @blogger.to_json(:methods => [ :profile_pic, :background_pic])
            end
            
             # Method to create a new @blog using the safe params we setup.
            def create
                @blogger = Blogger.new(blogger_params)
                blogger_present = Blogger.exists?(user_id: current_user.id)
                if blogger_present
                    response = { message: 'User already has a profile'}
                    render json: response, status: :created 
                else
                    if @blogger.save
                        response = { message: 'blog created successfully'}
                        render json: response, status: :created 
                    else
                        render json: @blogger.errors, status: :bad
                    end
                end
            end
            # Method to edit a specific @blog. @blog will need to be authorized.
            def current
                render json: @blogger
            end
            # Method to update a specific @blog. @blog will need to be authorized.
            def update
                if @blogger.update(blogger_params) 
                render json: { status: 200, msg: 'blog details have been updated.' }
                end
            end

            # Method to delete a @blog, this method is only for admin accounts.
            def destroy
                if @blogger.destroy
                render json: { status: 200, msg: 'User has been deleted.' }
                end
            end
            def profile_pic
                @blogger = Blogger.find(params[:id])
                send_file @blogger.profile_pic.path, :type => @blogger.profile_pic_content_type
            end
            def background_pic
                @blogger = Blogger.find(params[:id])
                send_file @blogger.background_pic.path, :type => @blogger.background_pic_content_type
            end
            private
            
            # Setting up strict parameters for when we add account creation.
            def blogger_params
                params.permit(:first_name, :surname, :profile_pic, :profile_id, :bio, :interests, :city, :twitter, :country, :linkedin, :facebook, :instagram, :medium_prof, :background_pic).merge(user_id: current_user.id)
            end
            # Adding a method to check if current_user can update itself. 
            # This uses our blogger method.
            def find_blogger
                @blogger = Blogger.find(params[:id])
            end 

            def authorize
                render json: { error: 'You are not authorized to modify this data'} , status: 401 unless current_user && @blogger.user_id == current_user.id
            end
        end
end
