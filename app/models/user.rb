class User < ApplicationRecord
    has_secure_password
    enum role: {student: 0, teacher: 1, admin: 2}

    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: {minimum: 6}
    validates :firstname, presence: true
    validates :lastname, presence: true
    validates :role, presence: true

    validates :grade, presence: true, if: -> {role == 'student'}
    validates :subject_specialization, presence: true, if: -> {role == 'teacher'}
    validates :qualification, presence: true, if: -> {role == 'teacher'}
    validates :guardian_contact, presence: true, if: -> {role == 'student'}
end
