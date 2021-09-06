class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    puts "Station Name: #{name}"
    @trains = []
  end

  def get_train(train)
    trains << train
    puts "To the #{name} station arrived train #{train.number}"
  end

  def trains_by_type(type)
    puts "Trains at the #{name} type #{type}: "
    trains.each { |train| puts train.number if train.type == type }
  end

  def send_train(train)
    trains.delete(train)
    train.station = nil
    puts "From the station #{name} departure train № #{train.number}"
  end

  def show_trains(type = nil)
    if type
      puts "Trains on statioin #{name} type #{type}: "  
      @trains.each{|train| puts train.number if train.type == type}
    else
      puts "Trains on station #{name}: "
      @trains.each{|train| puts train.number}
    end
end

end