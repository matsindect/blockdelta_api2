class ApplicationController < ActionController::API
    before_action :authenticate_request
    # protect_from_forgery with: :null_session
    attr_reader :current_user
    
    include ExceptionHandler
    include Knock::Authenticable 

    private

    def authorize_as_admin
        render json: { error: 'Not Authorized' }, status: 401  unless !current_user.nil? && current_user.is_admin?
    end

    def authorize_as_blogger
          render json: { error: 'Not Authorized' }, status: 401  unless current_user.is_admin? || (!current_user.nil? && current_user.is_blogger?)
    end

    def authorize_as_candidate
      render json: { error: 'Not Authorized' }, status: 401  unless current_user.is_admin? || (!current_user.nil? && current_user.is_candidate? )
    end

    def authenticate_request
      @current_user = AuthorizeApiRequest.call(request.headers).result
      render json: { error: 'Not Authorized' }, status: 401 unless @current_user
    end
end
