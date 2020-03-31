module Api::V1
  class JobsmediaController < ApplicationController
    skip_before_action :authenticate_request, only: [:file,:index, :create, :media ]
    before_action :set_jobsmedium, only: [:show, :update, :destroy]

    # GET /jobsmedia
    def index
      @jobsmedia = Jobsmedium.all

      render json: @jobsmedia
    end

    # GET /jobsmedia/1
    def show
      render json: @jobsmedium
    end
    def media
      @items = Jobsmediaupload.all
      render :json => @items.to_json(:methods => [:file])
      # render json: @items
    end

    
    # POST /blogsmedia
    def create
      @blogsmedium = Jobsmedium.new(jobsmedium_params)

      if @blogsmedium.save
        if params[:file]
          params[:file].each do |image|
            @blogsmedium.jobsmediauploads.create(:file => image)
            @items = Jobsmediaupload.find_by_jobsmedium_id(@blogsmedium.id)
            @file = @items.file
          end
        end
        response = { message: 'Events media created successfully', location: @file}
        render json: response, status: :created 
      else
        render json: @blogsmedium.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /jobsmedia/1
    def update
      if @jobsmedium.update(jobsmedium_params)
        render json: @jobsmedium
      else
        render json: @jobsmedium.errors, status: :unprocessable_entity
      end
    end

    # DELETE /jobsmedia/1
    def destroy
      @jobsmedium.destroy
    end

    def file
      @blog = Jobsmediaupload.find(params[:id])
      send_file @blog.file.path, :type => @blog.file_content_type
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_jobsmedium
        @jobsmedium = Jobsmedium.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def jobsmedium_params
        params.permit(:file => [])
      end
  end
end
