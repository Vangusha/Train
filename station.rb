class Station
  atter_reader :name, :trains
  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def delete_train(train)
    @trains.delete(train)
  end

  def type_trains(carrige)
    @trains.count { |train| train.type == carrige.to_sym }
  end
end