class AuthenticationController < ApplicationController
    skip_before_action :authenticate_request, only[:login]

    def login
        @user = User.find_by_email(params[:email])
        if @user&.authenticate(params[password]){
            token = JsonWebToken.encode(user_id: @user.id)
            render json: {token: token, user: @user}, status: :ok
        } else {
            render json: {error: "Ivalid email or password"}, status: 401
        }
    end
end