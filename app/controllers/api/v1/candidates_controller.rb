module Api::V1
        class CandidatesController < ApplicationController
            before_action :authenticate_user,  only: [ :index, :update, :current, :profile_pic, :cover_letters, :resumes]
            before_action :authorize_as_candidate, only: [:create,:destroy, :current]
            before_action :find_candidate, only: [:show, :update, :destroy, :current, :authorize]
            before_action :authorize,          only: [ :update, :current, :destroy]
            
            
        
            # Should work if the current_user is authenticated.
            def index
                @candidate = Candidate.filter(params.slice(:user_id))
                render :json => @candidate.to_json(:methods => [ :profile_pic, :resume, :cover_letter])
            end
            def show
                render :json => @candidate.to_json(:methods => [ :profile_pic, :resume, :cover_letter])
            end
             # Method to create a new @blog using the safe params we setup.
            def create
                @candidate = Candidate.new(candidate_params)
                candidate_present = Candidate.exists?(user_id: current_user.id)
                if candidate_present
                    response = { message: 'User already has a profile'}
                    render json: response, status: :created 
                else
                    if @candidate.save
                        response = { message: 'candidate created successfully'}
                        render json: response, status: :created 
                    else
                        render json: @candidate.errors, status: :bad
                    end
                end
            end
            # Method to edit a specific @blog. @blog will need to be authorized.
            def current
                render json: @candidate
            end
            # Method to update a specific @blog. @blog will need to be authorized.
            def update
                if @candidate.update(candidate_params)
                render json: { status: 200, msg: 'candidate details have been updated.' }
                end
            end

            # Method to delete a @blog, this method is only for admin accounts.
            def destroy
                if @candidate.destroy
                render json: { status: 200, msg: 'candidate has been deleted.' }
                end
            end

            def profile_pic
                @candidate = Candidate.find(params[:id])
                send_file @candidate.profile_pic.path, :type => @candidate.profile_pic_content_type
            end
            def cover_letters
                @candidate = Candidate.find(params[:id])
                send_file @candidate.cover_letter.path, 
                        :type => @candidate.cover_letter_content_type
            end

            def resumes
                @resume = Candidate.find(params[:id])
                send_file @resume.resume.path, 
                        :type => @resume.resume_content_type
            end
            
            private
        
            # Setting up strict parameters for when we add account creation.
            def candidate_params
                params.permit(:first_name, :surname, :profile_pic, :phone, :cover_letter, :resume).merge(user_id: current_user.id)
            end
            # Adding a method to check if current_user can update itself. 
            # This uses our blogger method.
            def find_candidate
                @candidate = Candidate.find(params[:id])
            end 

            def authorize
                render json: { error: 'You are not authorized to modify this data'} , status: 401 unless current_user && @candidate.user_id == current_user.id
            end
        end
end
