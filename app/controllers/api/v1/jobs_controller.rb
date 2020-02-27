module Api
    module V1        
        class JobsController < ApplicationController
            before_action :authenticate_user,  only: [ :index, :update, :current]
            before_action :authorize_as_blogger, only: [:create,:destroy, :current]
            before_action :authorize,          only: [:update, :current]
            
        
            # Should work if the current_user is authenticated.
            def index
                @job = Job.all.order("created_at DESC")
                render json: @categories
            end

             # Method to create a new @blog using the safe params we setup.
            def create
                @job = Job.new(category_params)
                if @job.save
                    response = { message: 'category created successfully'}
                    render json: response, status: :created 
                else
                    render json: @job.errors, status: :bad
                end
            end
            # Method to edit a specific @blog. @blog will need to be authorized.
            def current
                @job = Job.find(params[:id])
                render json: @job
            end
            # Method to update a specific @blog. @blog will need to be authorized.
            def update
                @job = Job.find(params[:id])
                if @job.update(category_params)
                render json: { status: 200, msg: 'category details have been updated.' }
                end
            end

            # Method to delete a @blog, this method is only for admin accounts.
            def destroy
                @job = Job.find(params[:id])
                if @job.destroy
                render json: { status: 200, msg: 'category has been deleted.' }
                end
            end
            private
        
            # Setting up strict parameters for when we add account creation.
            def category_params
                params.require(:job).permit(:job_title, :job_location, :job_deadline, :job_role, :job_salary, :job_description, :sector_id, :category_id)
            end
            # Adding a method to check if current_user can update itself. 
            # This uses our blogger method.
            def authorize
                render json: { error: 'You are not authorized to modify this data'} , status: 401 unless current_user && current_user.can_modify_user?(params[:id])
            end
        end
    end
end
