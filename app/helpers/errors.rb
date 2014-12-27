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
		if error.message
			error.message
		else
			false
		end
	end
end