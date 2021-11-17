class User < ApplicationRecord
    # validates :username, :password_digest, presence: true
    # validates :password, length: {minimum: 6}, allow_nil: true

    attr_reader :password
    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def self.find_by_credentials(username, password)
       #debugger
       user = User.find_by(username: username)
       return user if user && BCrypt::Password.new(self.password_digest).is_password?(password)
       nil 
    end

end
