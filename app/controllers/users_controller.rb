class UsersController < ApplicationController
	
	before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
	before_filter :correct_user, :only => [:edit, :update]
	before_filter :admin_user, :only => :destroy

	attr_accessor :password

  	def new
  		@user = User.new
		@title = "Sign up"
  	end

  	def index
		@title = "All users"
		@users = User.paginate(:page => params[:page])
	end

  	def show
		@user = User.find(params[:id])
		@microposts = @user.microposts.paginate(:page => params[:page])
		@title = @user.name.split().each {|x| x.capitalize!}.join(" ")
	end

	def edit
		@title = "Edit user"
	end

	def create
		@user = User.new(user_params)
		if @user.save
			# Handle a successful save.
			sign_in @user
			flash[:success] = "Welcome to Tweetter!"
			redirect_to @user
		else
			@title = "Sign up"
			render 'new'
		end
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)#params[:user]
			flash[:success] = "Profile updated."
			redirect_to @user
		else
			@title = "Edit user"
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User deleted."
		redirect_to users_path
	end


	def following
		@title = "Following"
		@user = User.find(params[:id])
		@users = @user.following.paginate(:page => params[:page])
		render 'show_follow'
	end

	def followers
		@title = "Followers"
		@user = User.find(params[:id])
		@users = @user.followers.paginate(:page => params[:page])
		render 'show_follow'
	end

	private

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation, :salt, :encrypted_password)
		end

		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end

		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end
end