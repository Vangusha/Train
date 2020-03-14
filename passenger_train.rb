class PassengerTrain < Train
  def type
    'пассажирский'
  end

  def add_carriage(carriage)
    @carriages << carriage if carriage.is_a? PassengerCarriage
  end
end