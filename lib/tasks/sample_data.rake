namespace :db do
	require 'faker'
	desc "Fill database with sample data"
	task :populate => :environment do
		Rake::Task['db:reset'].invoke
		admin = User.create!(:name => "Sachin Shinde",
				:email => "sachin.shinde1092@gmail.com",
				:password => "foobar",
				:password_confirmation => "foobar")
		admin.toggle!(:admin)
		99.times do |n|
			name = Faker::Name.name
			email = name.split().join().downcase + "@gmail.com"
			password = "password"
			User.create!(:name => name,
				:email => email,
				:password => password,
				:password_confirmation => password)
		end

		User.first(6).each do |user|
			50.times do
				user.microposts.create!(:content => Faker::Lorem.sentence(5))
			end
		end
	end
end