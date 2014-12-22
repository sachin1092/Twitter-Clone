class User < ActiveRecord::Base
	
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	def user_params
		params.require(:user).permit(:name, :email)
	end

	validates :name, :presence => true, 
					:length => { :maximum => 50 }
	validates :email, :presence => true, 
					:format => { :with => email_regex },
					:uniqueness => { :case_sensitive => false }
end
