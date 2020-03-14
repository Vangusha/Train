class CargoTrain < Train
  def type
    'грузовой'
  end

  def add_carriage(carriage)
    @carriages << carriage if carriage.is_a? CargoCarriage
  end
end