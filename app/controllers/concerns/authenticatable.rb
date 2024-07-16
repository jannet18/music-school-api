module Authenticatable
    extend ActiveSupport::Concern
    included do
        before_action :authenticate_request
    end

    def authenticate_request
        token = request.headers["Authorization"]&.split(" ")&.last
        begin
        decoded = JWT.decode(token)
        @current_user = User.find_by(id: decoded[:user_id]) if decoded
        rescue JWT::DecodeError
        render json: {error: "Not Authorized"}, status: :unauthorized 
        return 
        end
        render json: {error: "Not Authorized"}, status: :unauthorized unless @current_user
    end

    def current_user
        @current_user
    end
end