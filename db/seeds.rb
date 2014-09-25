# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = ['Sam', 'Jane','Fred','Kim','Jack']

users.each do |user|
  User.create!(
    name: user,
    email: "#{user}@email.com",
    password: 'password',
    password_confirmation: 'password',
    phone: 8015551234)
end


User.all.each do |user|
  Project.create!(
    name: "#{user.name}'s Project",
    description: "This project was created by #{user.name}. This project was created by #{user.name}. This project was created by #{user.name}. This project was created by #{user.name}. ",
    due_date_at: "2015-09-29 00:00:00",
    creator: user)
end

User.all.each do |user|
  Project.all.each do |project|
    Task.create!(
      name: "#{user.name}'s task for #{project.name} ",
      description: "This task is #{project.name}. This task is in #{project.name}. This task is in #{project.name}. " ,
      delivery_minutes: 10,
      is_completed: false,
      project_id: project.id,
      creator_id: user.id,
      user_id: user.id == 1 ? 5 : user.id - 1)
  end
end

