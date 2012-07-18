require 'machinist/active_record'

User.blueprint do
	name { Faker::Name.name }
	email { Faker::Internet.email }
	password { "secret" }
end

Expense.blueprint do
	description { "Buy a Kindle" }
	amount { 199.99 }
	user { User.make! }
end

Income.blueprint do
	description { "I win the Lotery" }
	amount { 5000 }
	user { User.make! }
end
