class UsersController < ApplicationController
    skip_before_action :authorize_admin, only: [:index]
    def index
        @users = User.all
        render json: @users
    end

    def show
        @user = User.find(params[:id])
        render json @user
    end

    def create
        @user = User.new(user_params)
        if @user.save
            render json: {@user, status: :created}
        else 
            render json: {@user.errors}, status: :uprocessable_entity
        end
    end

    private 
    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :role)
    end

    def authorize_admin
        return if current_user.admin?
        render json; {error: "Not Authorized"}, status: :unauthorized
    end
end