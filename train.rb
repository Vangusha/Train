class Train
  attr_reader :carriages, :station, :number, :speed, :route
  include Manufacturer
  include InstanceCounter
  include Validation
  @@trains = {}

  NUMBER_TYPE = /^[a-zа-я0-9]{3}-?[a-zа-я0-9]{2}$/i

  def initialize(number)
    @number = number
    validate!
    @carriages = []
    @speed = 0
    @route_index = 0
    @@trains[self.number] = self
    register_instance
  end

  def self.find(number)
    @@trains[number]
  end

  def route=(route)
    current_station.delete_train(self) unless @route.nil?
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

  def each_carriage
    @carriages.each.with_index(1) { |carriage, x| yield(carriage, x) } unless @carriages.empty?
  end

  private

  def validate!
    raise 'Введен неверный формат номера, пример XXX-XX или XXXXX (только цифры и буквы)' if number !~ NUMBER_TYPE
    raise 'Такой поезд уже существует' if @@trains[number] && @@trains[number] != self
    true
  end
end