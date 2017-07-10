require_relative 'contact.rb'

class CRM

  def initialize
    @main_menu = true


  end

  def main_menu
  while true # repeat indefinitely
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
      when 6 then exit
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

  Contact.create(first_name, last_name, email, note)
end

  def modify_existing_contact
    print 'What contact would you like to modify? Please enter their last name.'
    name = gets.chomp

    print 'Which would you like modify: first_name, last_name, email, or note?'
    attribute = gets.chomp

    print 'And what would you like to change it to?'
    value = gets.chomp

    Contact.find_by('last_name', name).update(attribute, value)

  end

  def delete_contact
    print "What is the last name of the contact you would like to delete? \r\n"
    name = gets.chomp

    print "Contact #{name} has been deleted.\r\n"
    Contact.find_by('last_name', name).delete(name)

  end

  def display_all_contacts
   print Contact.all.inspect
  end

  def search_by_attribute
    print "Please enter the attribute you would like to search by, first_name, last_name, or email."
    attribute = gets.chomp

    print "Now put in the value of that field to search."
    value = gets.chomp

    Contact.find_by(attribute, value)
    
  end


end

a_crm_app = CRM.new
a_crm_app.main_menu
