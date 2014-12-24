class RelationshipsController < ApplicationController
	before_filter :authenticate

	def create
		@user = User.find(params[:relationship][:followed_id])
		if !current_user.following?(@user)
			current_user.follow!(@user)
			respond_to do |format|
				format.html { redirect_to @user }
				format.js
			end
		end
	end

	def destroy
		begin
			@user = Relationship.find(params[:id]).followed
			if !@user.nil?
				current_user.unfollow!(@user)
				respond_to do |format|
					format.html { redirect_to @user }
					format.js
				end
			end
		rescue Exception => ex
			respond_to do |format|
				format.html { redirect_to @user }
			end
		end
	end
end