namespace :retailers do
  desc 'Create fake people'
  task :make_fake_people => :environment do
    puts 'Deleting old people...'
    Person.all.each {|person| person.destroy}
    puts 'Creating 100 new people...'
    100.times do
      name = Faker::Name.name
      Person.create!(:name => name)
    end
    puts 'Done!'
  end
end