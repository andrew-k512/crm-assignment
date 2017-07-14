require_relative 'contact.rb'

class CRM < Contact

  def main_menu
    while true
      print_main_menu
      user_selected = gets.to_i
      call_option(user_selected)
    end
  end

  def print_main_menu
    puts '[1] Add a new contact'
    puts '[2] Modify an existing contact'
    puts '[3] Delete a contact'
    puts '[4] Display all the contacts'
    puts '[5] Search by attribute'
    puts '[6] Exit'
    puts 'Enter a number: '
  end

  def call_option(user_selected)
    case user_selected
    when 1 then add_new_contact
    when 2 then modify_existing_contact
    when 3 then delete_contact
    when 4 then display_all_contacts
    when 5 then search_by_attribute
    when 6 then
      puts "Exiting..."
      exit
    end
  end

  def add_new_contact
    print 'Enter First Name: '
    first_name = gets.chomp

    print 'Enter Last Name: '
    last_name = gets.chomp

    print 'Enter Email Address: '
    email = gets.chomp

    print 'Enter a Note: '
    note = gets.chomp

    # Contact.create(first_name, last_name, email, note)

    contact = Contact.create(
      first_name: first_name,
      last_name:  last_name,
      email:      email,
      note:       note,
    )

  end

  def modify_existing_contact
    print 'Enter the id of the contact you would like to modify: '
    puts""
    id = gets.to_i
    contact = Contact.find(id)

    print 'What attribute would you like to change?'
    puts ""
    print '1 = First name, 2 = Last name, 3 = Email, 4 =Note'
    puts ""
    attribute_number = gets.to_i
    attribute_name = translate_attribute_num_to_name(attribute_number)

    print "What is the new #{attribute_name}?"
    puts""
    attribute_value = gets.chomp

    # contact.update(attribute_name, attribute_value)
    # contact.update(:last_name => attribute_value)
    contact.update(attribute_name => attribute_value)
  end


  def delete_contact
    # display_all_contacts
    print 'Enter the id of the contact you want to delete: '
    puts ""
    id = gets.to_i

    contact = Contact.find(id)
    contact.delete

    # Contact.find_by('first_name', name).delete
    # display_all_contacts
  end




#==============================Three separate display methods used in different parts of this file

# def display_all_contacts
#    print "Now displaying all contacts..."
#    print "\n"
#    print Contact.all.inspect
#    print "\n"
# end

  def display_all_contacts
    all = Contact.all
    all.each do |contact|
    puts "#{contact.id}: #{contact.last_name}, #{contact.first_name}. #{contact.email}. #{contact.note}"
    end
  end


  def translate_attribute_num_to_name(attribute_number)
    case attribute_number
    when 1 then
       :first_name
    when 2 then
       :last_name
    when 3 then
       :email
    when 4 then
       :note
    end
  end


end

z = CRM.new
z.main_menu


at_exit do
  ActiveRecord::Base.connection.close
end
# By default, SQLite allows 5 concurrent connections. Unfortunately, MiniRecord
# will open connections, but it won't close them automatically. What this means
# is that every 6th time you restart your CRM, there won't be any connections left
# and you'll get a mysterious Timeout error.
# This will ensure that as long as your program shuts down gracefully,
# it'll close the connection to the database.
