# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.create(:name => "Admin") if Role.where(:name => "Admin").blank?
Role.create(:name => "Client") if Role.where(:name => "Client").blank?
admin_role_id = Role.where(:name => "Admin").first.id rescue nil
demoUser = User.create(:first_name => "evoting", :last_name => "admin", username: "evoting", :email => "evoting@gmail.com", :password => "evote123", :role_id => admin_role_id )

if Poll.where(:title => "Volunteer Opportunities").blank?
  poll = Poll.create(:title => "Volunteer Opportunities", :info => "Please sign up for any of the jobs below.")
  if poll.present?
    Answer.create(:poll => poll, :answer => "A. T-Shirts sales") if Answer.where(:poll => poll, :answer => "A. T-Shirts sales").blank?
    Answer.create(:poll => poll, :answer => "B. Runner") if Answer.where(:poll => poll, :answer => "B. Runner").blank?
    Answer.create(:poll => poll, :answer => "C. Timer") if Answer.where(:poll => poll, :answer => "C. Timer").blank?
  end
end
