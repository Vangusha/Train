class Route
  include Validation
  attr_reader :name, :stations
  def initialize(station_start, station_end)
    @stations = [station_start, station_end]
    validate!
    @name = "#{station_start.name}-#{station_end.name}"
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

  def show_stations
    @stations.each.with_index(1) do |station, x|
      puts "#{x}. #{station.name}"
    end
  end

  private

  def validate!
    raise 'Переданы неверные аргументы' unless (@stations.first.is_a? Station) && (@stations.last.is_a? Station)
    true
  end
end