# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


[:admin, :newuser].each do |role|
  Role.where({ name: role }, without_protection: true).first_or_create
end

u1 = User.create({name: "Teste", email: "t@e.com", password: "123456", password_confirmation: "123456", occupation: "Ocupação", graduation: "Graduação"}).add_role(:admin).reload
u2 = User.create :name => "Victor", :email => "v@e.com", :password => "123456", :password_confirmation => "123456", :occupation => "Ocupação", :graduation => "Graduação"
