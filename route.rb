class Route
  attr_reader :name, :stations
  def initialize(station_start, station_end)
    @stations = [station_start, station_end]
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
end