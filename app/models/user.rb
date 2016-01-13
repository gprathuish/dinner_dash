class User < ActiveRecord::Base
	has_many :orders, dependent: :destroy
	validates :first_name, :last_name, :email,presence: true
	validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: 'Not a valid Email'}
	validates :display_name, length: { in: 3..32 },  :allow_blank => true
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

	has_secure_password

	def full_name
		[first_name, last_name].join(' ')		
	end

	
end
