class PassengerTrain < Train
  def type
    'пассажирский'
  end

  def add_carriage(carriage)
    if carriage.class == PassengerCarriage
      @carriages << carriage
    end
  end
end