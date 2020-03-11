class Station
  attr_reader :name, :trains
  @@all_stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@all_stations << self
  end

  def self.all
    @@all_stations
  end

  def add_train(train)
    @trains << train
  end

  def delete_train(train)
    @trains.delete(train)
  end

  def station_trains
    puts "Поездов на станции #{@trains.size}"
    if @trains.any?
      @trains.each.with_index(1) do |train, x|
        puts "#{x}. Поезд #{train.number}"
      end
    end
  end
end