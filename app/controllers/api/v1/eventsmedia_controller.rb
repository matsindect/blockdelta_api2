module Api::V1
  class EventsmediaController < ApplicationController
    skip_before_action :authenticate_request, only: [:file, :index, :create, :media ]
    before_action :set_eventsmedium, only: [:show, :update, :destroy]

    # GET /eventsmedia
    def index
      @eventsmedia = Eventsmedium.all

      render json: @eventsmedia
    end

    # GET /eventsmedia/1
    def show
      render json: @eventsmedium
    end
    def media
      @items = Eventsmediaupload.all
      render :json => @items.to_json(:methods => [:file])
      # render json: @items
    end

    
    # POST /blogsmedia
    def create
      @blogsmedium = Eventsmedium.new(eventsmedium_params)

      if @blogsmedium.save
        if params[:file]
          params[:file].each do |image|
            @blogsmedium.eventsmediauploads.create(:file => image)
            @items = Eventsmediaupload.find_by_eventsmedium_id(@blogsmedium.id)
            @file = @items.file
          end 
        end
        
         response = { message: 'Events media created successfully' , location: @file}
        render json: response, status: :created 
      else
        render json: @blogsmedium.errors, status: :unprocessable_entity
      end
    end
    
    # PATCH/PUT /eventsmedia/1
    def update
      if @eventsmedium.update(eventsmedium_params)
        render json: @eventsmedium
      else
        render json: @eventsmedium.errors, status: :unprocessable_entity
      end
    end

    # DELETE /eventsmedia/1
    def destroy
      @eventsmedium.destroy
    end

    def file
      @blog = Eventsmediaupload.find(params[:id])
      send_file @blog.file.path, :type => @blog.file_content_type
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_eventsmedium
        @eventsmedium = Eventsmedium.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def eventsmedium_params
        params.permit(:file => [])
      end
  end
end
