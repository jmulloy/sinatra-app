class User < ActiveRecord::Base

    has_many :lists
    has_secure_password
    validates :username, uniqueness:  {case_sensitive: false}
    validates :email,presence: true

end