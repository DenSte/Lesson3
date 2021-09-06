class PassengerTrain < Train
  def initialize(number, type = "passenger")
    super
  end

  def add_carriage(carriage)
    if carriage.instance_of?(PassengerCarriage)
      super(carriage)
    else
      puts "Passenger trains can have only passenger carriages"
    end 
  end

end