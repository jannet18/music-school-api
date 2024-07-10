module Authenticatable
    extend ActiveSupport::Concern

    include do
        before_action :authenticate_request
    end

    def authenticate_request
        token = request.headers["Authorization"]&.split(" ")&.last
        decoded = JsonWebToken.decode(token)
        @current_user = User.find_by(id: decoded[:user_id]) if decoded
        render json: {error: "Not Authorized"}, status: :unathorized unless @current_user
    end

    def current_user
        @current_user
    end
end