class User < ActiveRecord::Base
	attr_accessor :remember_token
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
	has_secure_password
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
													  BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end
	def User.new_token
		SecureRandom.urlsafe_base64
	end
	def remember
    self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end
	# Returns true if the given token matches the digest.
	def authenticated?(remember_token)
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end
	# Forgets a user.
	def forget
		update_attribute(:remember_digest, nil)
	end
end
