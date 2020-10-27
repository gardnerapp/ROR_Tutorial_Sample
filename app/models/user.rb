class User < ApplicationRecord
    #attr_accessor sets attribute
    #w/in class att accessed w self.attr_name 
    attr_accessor :remember_token
    
    before_save{self.email = email.downcase}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :name, presence: true, length: {maximum: 50}
    validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX},
   uniqueness: {case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: {minimum: 6}, allow_nil: true 
    
    #rembers token in the database allowing for persistent sessions
    def remember 
        # sets token to a randomnly generated token
        # self ensures that a local variable is not created 
        # self allows us to create a specific rememeber token for a user which is 
        #stored in the DB 
        self.remember_token = User.new_token
        update_attribute(:remember_token, User.digest(remember_token))
    end
    
    #Returns true if givn token matches digest 
    def authenticated?(remember_token)
        return false if remember_digest.nil? 
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end 
    
    def forget
        update_attribute(:remember_digest, nil)
    end 
    
    

    # Creates self sub class which holds unique stuff to that model instance  are unquie to each 
    class << self 
        # Returns hash digest  of a given string
        def digest(string)
            cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                          BCrypt::Engine.cost
            BCrypt::Password.create(string, cost: cost )
        end 
         
         #Creates a token for a user 
        def new_token
            SecureRandom.urlsafe_base64
        end 
        
    end 
end
