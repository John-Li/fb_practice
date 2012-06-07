namespace :retailers do
  namespace :db  do
    desc 'Fill database with sample data'
    task :populate_fake_data => :environment do
      make_people
      make_associations
    end
  end
end

def make_people
  puts 'Deleting old people'
  Person.destroy_all
  puts 'Creating 100 new people'
  100.times do
    name = Faker::Name.name
    Person.create!(:name => name)
  end
  puts 'Done!'
end

def make_associations
  puts 'Deleting old associations'
  PersonFavourites.destroy_all
  puts 'Creating new associations'
  people = Person.all
  people.each do |man|
    random_people = []
    10.times {random_people << people[rand(10)+1]}
    random_people.uniq.each {|random_man| man.add_to_favourites!(random_man)}
  end
  puts 'Done!'
end

