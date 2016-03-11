require 'chronic'
require 'colorize'
# Find a third gem of your choice and add it to your project
require 'date'
require 'highline'
require_relative "lib/listable"
require_relative "lib/errors"
require_relative "lib/udacilist"
require_relative "lib/todo"
require_relative "lib/event"
require_relative "lib/link"

list = UdaciList.new(title: "Julia's Stuff")
list.add("todo", "Buy more cat food", due: "2016-02-03", priority: "low")
list.add("todo", "Sweep floors", due: "2016-01-30")
list.add("todo", "Buy groceries", priority: "high")
list.add("event", "Birthday Party", start_date: "2016-05-08")
list.add("event", "Vacation", start_date: "2016-05-28", end_date: "2016-05-31")
list.add("link", "https://github.com", site_name: "GitHub Homepage")
list.all
list.delete(3)
list.all

# SHOULD CREATE AN UNTITLED LIST AND ADD ITEMS TO IT
# --------------------------------------------------
new_list = UdaciList.new # Should create a list called "Untitled List"
new_list.add("todo", "Buy more dog food", due: "in 5 weeks", priority: "medium")
new_list.add("todo", "Go dancing", due: "in 2 hours")
new_list.add("todo", "Buy groceries", priority: "high")
new_list.add("event", "Birthday Party", start_date: "May 31")
new_list.add("event", "Vacation", start_date: "Dec 20", end_date: "Dec 30")
new_list.add("event", "Life happens")
new_list.add("link", "https://www.udacity.com/", site_name: "Udacity Homepage")
new_list.add("link", "http://ruby-doc.org")

# SHOULD RETURN ERROR MESSAGES
# ----------------------------
# new_list.add("image", "http://ruby-doc.org") # Throws InvalidItemType error
# new_list.delete(9) # Throws an IndexExceedsListSize error
# new_list.add("todo", "Hack some portals", priority: "super high") # throws an InvalidPriorityValue error

# DISPLAY UNTITLED LIST
# ---------------------
new_list.all

# DEMO FILTER BY ITEM TYPE
# ------------------------
new_list.filter("event")

# Initializing highline, a gem for user input
cli = HighLine.new

# Instructions to user for creating a new list
puts "-" * 15 + "\n"
puts "Please create a new list."
user_title = cli.ask "What is the name of your list? "

inputted_list = UdaciList.new(title: user_title)

user_params = []

# number_of_items = cli.ask "How many items would you like in your list?"

# Takes a list and the user inputted parameters and adds those parameters to the list
def input_list_creator(list, array)
  if array.length > 3
    hash = array[2].merge(array[3]) 
  else
    hash = array[2]
  end
  list.add(array[0], array[1], hash)
end


while true do
  cli.choose do |menu|
    menu.prompt = "Please select an item type or finish your list."
    menu.choice(:todo) { 
      user_params << "todo"
      user_params << cli.ask("Please enter a description")
      user_params << {due: cli.ask("Please enter a due date.")}
      cli.choose do |pri_menu|
        pri_menu.prompt = "Please select a priority."
          pri_menu.choice(:high){ user_params << {priority: "high"} }
          pri_menu.choice(:medium){ user_params << {priority: "medium"} }
          pri_menu.choice(:low){ user_params << {priority: "low"} } 
      end
      input_list_creator(inputted_list, user_params)
      user_params = []
      puts "*" * 10 + "\n"
     } 
    menu.choice(:event) {  
      user_params << "event"
      user_params << cli.ask("Please enter a description")
      user_params << {start_date: cli.ask("Please enter a start date.")}
      user_params << {end_date: cli.ask("Please enter an end date.")}
      puts "*" * 10 + "\n"
      input_list_creator(inputted_list, user_params)
      user_params = []
    }
    menu.choice(:link) { 
      user_params << "link"
      user_params << cli.ask("Please enter a link")
      user_params << {site_name: cli.ask("Please enter a site name.")}
      puts "*" * 10 + "\n"
      input_list_creator(inputted_list, user_params)
      user_params = []
    }
    menu.choice(:finish) { 
      inputted_list.all
      exit
    }
  end
end
