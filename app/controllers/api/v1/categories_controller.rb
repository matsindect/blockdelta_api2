module Api
    module V1       
        class CategoriesController < ApplicationController
            skip_before_action :authenticate_request, only: [:index , :current]
            before_action :authenticate_user,  only: [ :update]
            before_action :authorize_as_blogger, only: [:create,:destroy]
            before_action :authorize,          only: [:update]
            
        
            # Should work if the current_user is authenticated.
            def index
                @categories = Category.all.order("created_at DESC")
                render json: @categories
            end

             # Method to create a new @blog using the safe params we setup.
            def create
                @category = Category.new(category_params)
                if @category.save
                    response = { message: 'category created successfully'}
                    render json: response, status: :created 
                else
                    render json: @blog.errors, status: :bad
                end
            end
            # Method to edit a specific @blog. @blog will need to be authorized.
            def current
                @category = Category.find(params[:id])
                render json: @category
            end
            # Method to update a specific @blog. @blog will need to be authorized.
            def update
                @category = Category.find(params[:id])
                if @category.update(category_params)
                render json: { status: 200, msg: 'category details have been updated.' }
                end
            end

            # Method to delete a @blog, this method is only for admin accounts.
            def destroy
                @category = Category.find(params[:id])
                if @category.destroy
                render json: { status: 200, msg: 'category has been deleted.' }
                end
            end
            private
        
            # Setting up strict parameters for when we add account creation.
            def category_params
                params.permit(:name, :slug, :description)
            end
            # Adding a method to check if current_user can update itself. 
            # This uses our blogger method.
            def authorize
                render json: { error: 'You are not authorized to modify this data'} , status: 401 unless current_user && current_user.can_modify_user?(params[:id])
            end
        end
    end
end
