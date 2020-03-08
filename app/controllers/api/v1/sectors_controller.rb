module Api::V1
        class SectorsController < ApplicationController
            skip_before_action :authenticate_request, only: [:index, :current]
            before_action :authenticate_user,  only: [:update,]
            before_action :authorize_as_admin, only: [:create,:destroy]
            before_action :authorize,          only: [:update,]
            
        
            # Should work if the current_user is authenticated.
            def index
                @sectors = Sector.all.order("created_at DESC")
                render json: @sectors
            end

             # Method to create a new @blog using the safe params we setup.
            def create
                @sector = Sector.new(sector_params)
                if @sector.save
                    response = { message: 'sector created successfully'}
                    render json: response, status: :created 
                else
                    render json: @sector.errors, status: :bad
                end
            end
            # Method to edit a specific @blog. @blog will need to be authorized.
            def current
                @sector = Sector.find(params[:id])
                render json: @sector
            end
            # Method to update a specific @blog. @blog will need to be authorized.
            def update
                @sector = Sector.find(params[:id])
                if @sector.update(category_params)
                render json: { status: 200, msg: 'sector details have been updated.' }
                end
            end

            # Method to delete a @blog, this method is only for admin accounts.
            def destroy
                @sector = Sector.find(params[:id])
                if @sector.destroy
                render json: { status: 200, msg: 'category has been deleted.' }
                end
            end
            private
        
            # Setting up strict parameters for when we add account creation.
            def sector_params
                params.permit(:name, :slug, :description)
            end
            # Adding a method to check if current_user can update itself. 
            # This uses our blogger method.
            def authorize
                render json: { error: 'You are not authorized to modify this data'} , status: 401 unless current_user && current_user.can_modify_user?(params[:id])
            end
        end
end
