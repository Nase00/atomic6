helpers do
	def incorrect_password
		params["incorrect_password"] == "true"
	end

	def mismatch
		params["mismatch"] == "true"
	end

	def catch_errors(model)
	  model.save!
	rescue ActiveRecord::RecordInvalid => error
		case error.message
		when "Validation failed: Title can't be blank, Content can't be blank"
			"all_blank"
		when "Validation failed: Title can't be blank"
			"title_blank"
		when "Validation failed: Content can't be blank"
			"content_blank"
		else
			false
		end
	end
end