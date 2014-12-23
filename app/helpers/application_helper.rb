module ApplicationHelper
# Return a title on a per-page basis.
	def title
		base_title = "Tweetter"
		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end
	end

	def flash_class(level)
        case level
			when 'notice' then "alert alert-info"
			when 'success' then "alert alert-success"
			when 'error' then "alert alert-danger"
			when 'alert' then "alert alert-warning"
        end
	end
end