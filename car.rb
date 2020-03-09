require_relative 'car' # пример
class Car
  attr_accessor :current_rpm

  def initialize
    @current_rpm = 0
  end

  def start_engine
    start_engine! if engine_stoped?
  end

  def engine_stoped?
    current_rpm.zero?
  end  

  def start_engine!
    self.current_rpm = 700
  end

  #остановить двигатель
end 