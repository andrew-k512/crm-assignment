   # This method should work similarly to the find method above
# but it should allow you to search for a contact using attributes other than id
# by specifying both the name of the attribute and the value
# eg. searching for 'first_name', 'Betty' should return the first contact named Betty
def self.find_by(attribute, value)
  if attribute == 'first_name'
    @@contacts.each do |search|
      if search.first_name == value
        return @@contacts(search)
      end
    end
  elsif attribute == 'last_name'
    @@contacts.each do |search|
      if search.last_name == value
        return search
      end
    end
  elsif attribute == 'note'
    @@contacts.each do |search|
      if search.note == value
        return search
      end
    end
  elsif attribute == 'email'
    @@contacts.each do |search|
      if search.email == value
        return search
      end
    end
  end
end
