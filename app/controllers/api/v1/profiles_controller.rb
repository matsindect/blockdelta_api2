module Api
    module V1
        class ProfilesController < ApplicationController
            before_action :authenticate_user,  only: [ :index, :update, :current]
            before_action :authorize_as_blogger, only: [:create,:destroy, :current]
            before_action :authorize,          only: [:update, :current]
            
        
            # Should work if the current_user is authenticated.
            def index
                @profile = Profile.all.order("created_at DESC")
                render json: @profile
            end

             # Method to create a new @blog using the safe params we setup.
            def create
                @profile = Profile.new(blogger_params)
                if @profile.save
                    response = { message: 'blog created successfully'}
                    render json: response, status: :created 
                else
                    render json: @profile.errors, status: :bad
                end
            end
            # Method to edit a specific @blog. @blog will need to be authorized.
            def current
                @profile = Profile.find(params[:id])
                render json: @profile
            end
            # Method to update a specific @blog. @blog will need to be authorized.
            def update
                @profile = Profile.find(params[:id])
                if @profile.update(blogger_params)
                render json: { status: 200, msg: 'blog details have been updated.' }
                end
            end

            # Method to delete a @blog, this method is only for admin accounts.
            def destroy
                @profile = Profile.find(params[:id])
                if @profile.destroy
                render json: { status: 200, msg: 'User has been deleted.' }
                end
            end
            private
        
            # Setting up strict parameters for when we add account creation.
            def blogger_params
                params.require(:profile).permit(:name, :slug)
            end
            # Adding a method to check if current_user can update itself. 
            # This uses our blogger method.
            def authorize
                render json: { error: 'You are not authorized to modify this data'} , status: 401 unless current_user && current_user.can_modify_blog?(params[:id])
            end
        end
    end
end
