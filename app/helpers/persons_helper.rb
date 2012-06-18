module PersonsHelper
  def previous_person(people, person)
    previous_id = person.id-1
    people.find{ |p| p.id == previous_id}
  end

  def next_person(people, person)
    next_id = person.id+1
    people.find{ |p| p.id == next_id}
  end
end
