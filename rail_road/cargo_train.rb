class CargoTrain < Train
  def initialize(number, type = "cargo")
    super
  end

  def add_carriage(carriage)
    if carriage.instance_of?(CargoCarriage)
      super(carriage)
    else
      puts "Cargo train can have only cargo carriages"
    end
  end

end