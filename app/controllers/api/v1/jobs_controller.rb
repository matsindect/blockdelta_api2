module Api::V1       
        class JobsController < ApplicationController
            skip_before_action :authenticate_request, only: [:index, :current ]
            before_action :authenticate_user,  only: [:update]
            before_action :authorize_as_admin, only: [:create,:destroy]
            before_action :authorize,          only: [:update]
            
        
            # Should work if the current_user is authenticated.
            def index
                @job = Job.filter(params.slice(:sector_id, :category_id, :job_title)).order('created_at desc')
                render json: @job
            end

             # Method to create a new @blog using the safe params we setup.
            def create
                @job = Job.new(category_params)
                if @job.save
                    response = { message: 'Job created successfully'}
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
                params.permit(:job_title, :job_location, :job_deadline, :job_role, :job_salary, :job_description, :job_contact, :job_email, :meta_decription, :image_alt, :meta_keywords :sector_id).merge(user_id: current_user.id)
            end
            # Adding a method to check if current_user can update itself. 
            # This uses our blogger method.
            def authorize
                @job = Job.find(params[:id])
                render json: { error: 'You are not authorized to modify this data'} , status: 401 unless current_user && @job.user_id == current_user.id || (current_user && current_user.role == 'admin')
            end
        end
end
