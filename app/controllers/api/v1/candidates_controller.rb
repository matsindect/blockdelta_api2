module Api
    module V1
        class CandidatesController < ApplicationController
            before_action :authenticate_user,  only: [ :index, :update, :current]
            before_action :authorize_as_candidate, only: [:create,:destroy, :current]
            before_action :authorize,          only: [:update, :current]
            
        
            # Should work if the current_user is authenticated.
            def index
                @candidate = Candidate.all.order("created_at DESC")
                render :json => @candidate.to_json(:methods => [ :profile_pic])
            end

             # Method to create a new @blog using the safe params we setup.
            def create
                @candidate = Candidate.new(candidate_params)
                if @candidate.save
                    response = { message: 'candidate created successfully'}
                    render json: response, status: :created 
                else
                    render json: @candidate.errors, status: :bad
                end
            end
            # Method to edit a specific @blog. @blog will need to be authorized.
            def current
                @candidate = Candidate.find(params[:id])
                render json: @candidate
            end
            # Method to update a specific @blog. @blog will need to be authorized.
            def update
                @candidate = Candidate.find(params[:id])
                if @candidate.update(candidate_params)
                render json: { status: 200, msg: 'candidate details have been updated.' }
                end
            end

            # Method to delete a @blog, this method is only for admin accounts.
            def destroy
                @candidate = Candidate.find(params[:id])
                if @candidate.destroy
                render json: { status: 200, msg: 'candidate has been deleted.' }
                end
            end

            def profile_pic
                @candidate = Candidate.find(params[:id])
                send_file @candidate.profile_pic.path, :type => @candidate.profile_pic_content_type
            end
            private
        
            # Setting up strict parameters for when we add account creation.
            def candidate_params
                params.permit(:first_name, :surname, :profile_pic, :phone).merge(user_id: current_user.id)
            end
            # Adding a method to check if current_user can update itself. 
            # This uses our blogger method.
            def authorize
                render json: { error: 'You are not authorized to modify this data'} , status: 401 unless current_user && current_user.can_modify_candidate?(params[:id])
            end
        end
    end
end
