class UsersController < ApplicationController
	
	attr_accessor :password

  	def new
  		@user = User.new
		@title = "Sign up"
  	end

  	def show
		@user = User.find(params[:id])
		@title = @user.name
	end

	def create
		@user = User.new(user_params)
		if @user.save
			# Handle a successful save.
			flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
		else
			@title = "Sign up"
			render 'new'
		end
	end

	private

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation, :salt, :encrypted_password)
		end
end
