require_relative './train'
require_relative './cargo_carriage'
require_relative './passenger_carriage'
require_relative './cargo_train'
require_relative './passenger_train'
require_relative './route'
require_relative './station'
require_relative './main'


puts 'Добро пожаловать в меню управления ЖД'
main = Main.new
main.help
main.menu
