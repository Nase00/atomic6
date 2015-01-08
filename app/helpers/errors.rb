helpers do
	def incorrect_password
		params["incorrect_password"] == "true"
	end

	def mismatch
		params["mismatch"] == "true"
	end

	def catch_errors(model, params=nil, state="save")
		case state
		when "save"
		  model.save!
		when "update"
			model.update!(params)
		end
	rescue ActiveRecord::RecordInvalid => error
		if error.message
			error.message.sub(/Validation failed: /, '')
		else
			false
		end
	end
end
