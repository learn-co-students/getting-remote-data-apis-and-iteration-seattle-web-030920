def welcome
  puts "Welcome to the SWAPI command line interface!"
end

def get_character_from_user
  puts "Please enter a character name:"
  input = gets.chomp
  input
end
