# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)[]
fixture = [{code: 1, description: "get battery"},
	{code:2, description: "clean glass"},
	{code: 3, description: "get water"}
]
print "Criando tasks:"
fixture.each do |task|
	print "."
	Task.create(task)
end
puts ""