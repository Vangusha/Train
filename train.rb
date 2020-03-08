class Train
  attr_reader  :carriages, :station, :number, :type, :speed, :route
  def initialize(number, type, carriages)
    @number = number
    @type = type.to_sym
    @carriages
    @speed = 0
  end

  def break
    @speed = 0
  end

  def add_speed
    @speed += 10
  end

  def reduce_speed
    @speed -=10 if speed > 0
  end

  def add_carriage
    @carriages += 1 if speed ==0
  end

  def del_carriage
    @carriages -=1 if speed == 0 && carriages > 0
  end

  def set_route(route)
    unless @route.nil?
      current_station.delete_train(self)
    end
    @route_index = 0
    @route = route
    current_station.add_train(self)
  end

  def current_station
    @route.stations[@route_index]
  end

  def forward
    if current_station == @route.stations.last
      puts "Вы на конечной станции"
    else
      current_station.delete_train(self)
      @route_index += 1
      current_station.add_train(self)
    end
  end

  def backward
    if current_station == @route.stations.first
      puts "Вы на начальной станции"
    else
      current_station.delete_train(self)
      @route_index -= 1
      current_station.add_train(self)
    end
  end

  def next_station
    @route.stations[@route_index + 1]
  end

  def prev_station
    @route.stations[@route_index - 1]
  end



end