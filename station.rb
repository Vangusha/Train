class Station
  attr_reader :name, :trains
  include Validation
  @@all_stations = []

  def initialize(name)
    @name = name
    validate!
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

  def each_train
    @trains.each { |train| yield(train) } unless @trains.empty?
  end

  private

  def validate!
    raise 'Название не может быть пустым' if @name == ''
    raise 'Слишком большое название' if @name.length > 20
    raise 'Такая станция уже существует' if @@all_stations.map(&:name).include?(name) && !@@all_stations.include?(self)
    true
  end
end