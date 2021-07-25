class User < ApplicationRecord
    has_secure_password

    validates :email, presence: true
    validates :plan_type, presence: true
end
