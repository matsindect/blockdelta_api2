module Api::V1
  class BlogsmediaController < ApplicationController
    skip_before_action :authenticate_request, only: [:file, :index, :create, :media ]
    before_action :set_blogsmedium, only: [:show, :update, :destroy]

    # GET /blogsmedia
    def index
      @blogsmedia = Blogsmedium.all

      render json: @blogsmedia
    end

    # GET /blogsmedia/1
    def show
      render json: @blogsmedium
    end

    def media
      @items = Blogsmediaupload.all
      render :json => @items.to_json(:methods => [:file])
      # render json: @items
    end

    
    # POST /blogsmedia
    def create
      @blogsmedium = Blogsmedium.new(blogsmedium_params)

      if @blogsmedium.save
        if params[:file]
          params[:file].each do |image|
            @blogsmedium.blogsmediauploads.create(:file => image)
            @items = Blogsmediaupload.find_by_blogsmedium_id(@blogsmedium.id)
            @file = @items.file
          end 
        end
        response = { message: 'Blog media created successfully', location: @file}
        render json: response, status: :created 
      else
        render json: @blogsmedium.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /blogsmedia/1
    def update
      if @blogsmedium.update(blogsmedium_params)
        render json: @blogsmedium
      else
        render json: @blogsmedium.errors, status: :unprocessable_entity
      end
    end

    # DELETE /blogsmedia/1
    def destroy
      @blogsmedium.destroy
    end

    def file
      @blog = Blogsmediaupload.find(params[:id])
      send_file @blog.file.path, :type => @blog.file_content_type
    end
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_blogsmedium
        @blogsmedium = Blogsmedium.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def blogsmedium_params
        params.permit(:file =>[])
      end
  end
end
