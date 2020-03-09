class Main
  def initialize
    @trains = []
    @routes = []
    @stations = []
  end

  def menu
    loop do
      print 'Выберите пункт '
      choice = gets.chomp
      case choice
      when '1'
        create_station
      when '2'
        create_train
      when '3'
        create_route
      when '4'
        control_route
      when '5'
        set_route
      when '6'
        add_carriage
      when '7'
        delete_carriage
      when '8'
        control_train
      when '9'
        show_stations
      when '10'
        show_station_trains
      when 'exit', '11'
        exit
      when 'help'
        help
      else
        puts 'Неправильная команда, используйте help для помощи'
      end
    end
  end

  def help
    puts '1. Создать станцию'
    puts '2. Создать поезд'
    puts '3. Создать маршрут'
    puts '4. Управление маршрутом'
    puts '5. Назначить маршрут поезду'
    puts '6. Добавить вагон к поезду'
    puts '7. Отцепить вагон у поезда'
    puts '8. Управление поезда по маршруту'
    puts '9. Все станции'
    puts '10. Все поезда на станции'
    puts '11. Выйти'
  end

  private
  def create_station
    print 'Введите название станции: '
    name = gets.chomp
    @stations << Station.new(name)
    puts "Станция #{name} успешно создана"
  end

  def create_train
    puts "Какой поезд вы хотите создать?\n1.Пассажирский\n2.Грузовой"
    choice = gets.chomp
    print 'Введите номер поезда '
    number = gets.chomp
    case choice
    when '1'
      @trains << PassengerTrain.new(number)
    when '2'
      @trains << CargoTrain.new(number)
    end
    puts "Поезд #{number} успешно создан"
  end

  def create_route
    show_stations
    print 'Выберите начальную станцию '
    start_station = gets.to_i - 1
    print 'Выберите конечную станцию '
    end_station = gets.to_i - 1
    route = Route.new(@stations[start_station], @stations[end_station])
    @routes << route
    puts "Маршрут #{route.name} успешно создан"
  end

  def control_route
    puts 'Выберите маршрут'
    show_routes
    route = @routes[gets.to_i - 1]
    puts "Выбран маршрут #{route.name}"
    puts "1. Добавить станцию\n2. Удалить станцию"
    case gets.chomp
    when '1'
      puts 'Какую станцию добавить в маршрут?'
      show_stations
      route.add_station(@stations[gets.to_i - 1])
      puts 'Станция успешно добавлена'
    when '2'
      puts 'Какую станцию вы хотите удалть из маршрута?'
      route.show_stations
      route.delete_station(route.stations[gets.to_i - 1])
      puts 'Станция успешно добавлена'
    end
  end

  def set_route
    train = select_train

    puts 'Выберите маршрут'
    show_routes
    train.set_route(@routes[gets.to_i - 1])
    puts "Маршрут поезду #{train.number} успешно указан"
  end

  def add_carriage
    train = select_train
    print 'Сколько вагонов вы хотите добавить: '
    quantity = gets.to_i
    if train.class == PassengerTrain
      quantity.times do
        train.add_carriage(PassengerCarriage.new)
      end
    else
      quantity.times do
        train.add_carriage(CargoCarriage.new)
      end
    end
    puts "К поезду #{train.number} было добавлено #{quantity} вагонов"
  end

  def delete_carriage
    train = select_train
    print 'Сколько вагонов вы хотите отцепить: '
    quantity = gets.to_i
    quantity.times do
      train.del_carriage
    end
    puts "С поезда #{train.number} было отцеплено #{quantity} вагонов"
  end

  def control_train
    train = select_train

    puts "Отправить поезд #{train.number} на станцию\n1. Следующую\n2. Предыдущую"
    case gets.chomp
    when '1'
      train.forward
    when '2'
      train.backward
    end
    puts "После отправки поезд находится на станции #{train.current_station.name}"
  end

  def select_train
    puts 'Выберите поезд'
    trains
    train = @trains[gets.to_i - 1]
  end

  def trains
    @trains.each.with_index(1) {  |train, x| puts "#{x}. #{train.number} | вагонов #{train.carriages.size} | тип #{train.type}" }
  end

  def show_routes
    @routes.each.with_index(1) { |route, x| puts "#{x}. #{route.name}" }
  end

  def show_stations
    @stations.each.with_index(1) { |station, x| puts "#{x}. #{station.name} | поездов #{station.trains.size}" }
  end

  def show_station_trains
    puts 'Выберите станцию'
    show_stations
    station = @stations[gets.to_i - 1]
    station.station_trains
  end
end