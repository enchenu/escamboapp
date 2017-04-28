module Backoffice::AdminsHelper
	OptionsForRoles = Struct.new(:id, :description)

	def option_for_roles
		Admin.roles_i18n.map do |key, value|
			OptionsForRoles.new(key, value)
		end
	end
end
