# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

print 'Criando roles: '
print "."
r1 = Role.create({name: "Admin"})
print "."
r2 = Role.create({name: "User"})
print ".\n"
r3 = Role.create({name: "Guest"})

print 'Criando usuarios: '
u1 = User.create({name: "Teste", email: "t@e.com", password: "123456", password_confirmation: "123456", occupation: "Ocupação", graduation: "Graduação", role_id: r1.id})
print "."
u2 = User.create :name => "Victor", :email => "v@e.com", :password => "123456", :password_confirmation => "123456", :occupation => "Ocupação", :graduation => "Graduação", role_id: r2.id
print ".\n"

User.create({name: "Aff", email: "a@e.com", password: "123456", password_confirmation: "123456", occupation: "Ocupação", graduation: "Graduação", role_id: r1.id})

#   Mayor.create(name: 'Emanuel', city: cities.first)[]
fixture = [{code: 1, description: "get battery"},
	{code:2, description: "clean glass"},
	{code: 3, description: "get water"}
]
tasks =[]
print "Criando tasks:"
fixture.each do |task|
  print "."
  tasks << Task.create(task)
end

puts ""
print 'Criando robots: '
10.times do |k|
  Robot.create(identifier: (100000-k).to_s, status: k%10)
  print '.'
end

puts ""
print 'Criando robots info: '
10.times do |k|
  RobotInfo.create(battery: k%10, temperature: k%10, humidity: k%10, water: k%10, position: k%10, robot_id:k%10)
  print '.'
end

puts ""
print "Criando routines: "
10.times do |k|
  Routine.create(enable:true,
	 monthly: true,
	 time: Time.now,
	  sunday: true,
		monday: true,
		tuesday: true,
		wednesday:false,
		thursday: false,
		friday: true,
		saturday: false,
		task: tasks[k%3])
  print '.'
end
puts ""
