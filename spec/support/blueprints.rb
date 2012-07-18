require 'machinist/active_record'

User.blueprint do
	name { "user" }
	email { "user@email.com" }
	password { "secret" }
end
