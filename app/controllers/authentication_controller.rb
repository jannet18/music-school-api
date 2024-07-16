class AuthenticationController < ApplicationController
    skip_before_action :authenticate_request, only: [:login, :register]

    def register 
        @user = User.new(user_params)
        if @user.save
            render json: {message: "User Registered Successfully"}, status: :created
        else
            render json: {error: @user.errors.full_messages}, status: :uprocessable_entity
        end
    end
    def login
        @user = User.find_by(email: params[:email])
        if @user&.authenticate(params[:password])
            token = JsonWebToken.encode(user_id: @user.id)
            render json: {token: token, user: @user}, status: :ok
     else 
            render json: {error: "Invalid email or password"}, status: 401
     end
    end
    # t.string "email"
    # t.string "password_digest"
    # t.integer "role"
    # t.datetime "created_at", null: false
    # t.datetime "updated_at", null: false
    # t.date "date_of_birth"
    # t.string "grade"
    # t.string "guardian_contact"
    # t.string "subject_specialization"
    # t.string "qualifications"
    # t.string "contact_number"
    # t.string "firstname"
    # t.string "lastname"
    # t.boolean "accepted_terms"

    private 
    def user_params
        params.require(:user).permit(:firstname, :lastname, :email, :role ,  :password, :confirm_password, :contact_number, :accepted_terms, :grade, :qualifications, :date_of_birth, :subject_specialization, :guardian_contact )
    end
end