module Api::V1
        class EventsController < ApplicationController
            skip_before_action :authenticate_request, only: [:index, :current, :featured_image ]
            before_action :authenticate_user,  only: [:update]
            before_action :authorize_as_blogger, only: [:create,:destroy]
            before_action :authorize,          only: [:update]
            
        
            # Should work if the current_user is authenticated.
            def index
                @event = Event.filter(params.slice(:event_title))
                render :json => @event.to_json(:methods => [ :featured_image])
            rescue ActiveRecord::RecordNotFound
                render json: {}, status: :not_found
            end

             # Method to create a new @blog using the safe params we setup.
            def create
                @event = Event.create(event_params)
                if @event.save
                    response = { message: 'blog created successfully'}
                    render json: response, status: :created 
                else
                    render json: @event.errors, status: :bad
                end
            end
            # Method to edit a specific @blog. @blog will need to be authorized.
            def current
                @event = Event.find(params[:id])
                render json: @event
            end
            # Method to update a specific @blog. @blog will need to be authorized.
            def update
                @event = Event.find(params[:id])
                if @event.update(event_params)
                render json: { status: 200, msg: 'blog details have been updated.' }
                end
            end

            # Method to delete a @blog, this method is only for admin accounts.
            def destroy
                @event = Event.find(params[:id])
                if @event.destroy
                render json: { status: 200, msg: 'User has been deleted.' }
                end
            end
            
            def featured_image
                @event = Event.find(params[:id])
                send_file @event.featured_image.path, :type => @event.featured_image_content_type
            end
            private
            # def filtering_params(params)
            #     params.slice(:event_title, :event_start_date, :event_end_date)
            # end
            # Setting up strict parameters for when we add account creation.
            def event_params
                params.permit(:event_title, :event_start_date,:event_end_date, :event_venue, :event_description, :slug, :website, :featured_image, :sector_id, :category_id).merge(user_id: current_user.id)
            end
            # Adding a method to check if current_user can update itself. 
            # This uses our blogger method.
            def authorize
                render json: { error: 'You are not authorized to modify this data'} , status: 401 unless current_user && current_user.can_modify_blog?(params[:id])
            end
        end
end
