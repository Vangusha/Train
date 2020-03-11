class Train
  attr_reader :carriages, :station, :number, :speed, :route
  include Manufacturer
  include InstanceCounter
  @@trains = {}

  def initialize(number)
    register_instance
    @number = number
    @carriages = []
    @speed = 0
    @route_index = 0
    @@trains[self.number] = self
  end

  def self.find(number)
    @@trains[number]
  end

  def set_route(route)
    unless @route.nil?
      current_station.delete_train(self)
    end
    @route_index = 0
    @route = route
    current_station.add_train(self)
  end

  def brake
    @speed = 0
  end

  def add_speed
    @speed += 10
  end

  def reduce_speed
    @speed -= 10 if speed > 0
  end

  def del_carriage
    @carriages.delete_at(0)
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

  def current_station
    @route.stations[@route_index]
  end
end