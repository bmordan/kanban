require_relative "../lib/user.rb"
require_relative "../lib/board.rb"
require_relative "../lib/task.rb"

users = Hash.new

users["Anna"] = "https://www.toronto.ca/wp-content/uploads/2017/10/98c6-CityPlanning-TOcore-Avatar_Fernanda_400x400.png"
users["Peter"] = "https://www.toronto.ca/wp-content/uploads/2017/10/907e-CityPlanning-TOcore-Avatar_Peter_400x400.png"
users["Job"] = "https://www.toronto.ca/wp-content/uploads/2017/10/98d7-CityPlanning-TOcore-Avatar_Jerome_400x400.png"

users.each { |name, avatar| User.create(name: name, avatar: avatar) }

Board.create(title: "Default")
