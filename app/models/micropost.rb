class Micropost < ActiveRecord::Base
	# attr_accessible :content

	def micropost_params
		params.require(:micropost).permit(:content, :user_id)
	end

	belongs_to :user

	validates :content, :presence => true, :length => { :maximum => 140 }
	validates :user_id, :presence => true

	# default_scope{
	# 	where(order: 'microposts.created_at DESC')
	# }
	default_scope{ order('created_at DESC') }

end
