class Station

  attr_reader :station_name, :trains

  def initialize(station_name)

    @station_name = station_name
    puts "Station Name: #{station_name}"
    @trains = []
  end

  def get_train(train)
    trains << train
    puts "To the #{station_name} station arrived train #{train.number}"
  end

   def show_trains(type = nil)
      if type
        puts "Trains at the #{station_name} type #{type}: "  
        trains.each{|train| puts train.number if train.type == type}
      else
        puts "Trains at the #{station_name} station"
        trains.each{|train| puts train.number}
      end

  def send_train(train)
    trains.delete(train)
    train.station = nil
    puts "From the station #{station_name} departure train № #{train.number}"
  end
  end
end


class Route

  attr_accessor :stations, :from, :to

  def initialize (from, to)
    @stations = [from, to]
    puts "Route from  #{from.station_name} to #{to.station_name}"
  end

  def add_station(station)
    self.stations.insert(-2, station) 
    puts "Route from #{stations.first.station_name} - to #{stations.last.station_name} station #{station.station_name} was added"
  end

  def remove_station(station)
    if [stations.first, stations.last].include?(station)
      puts "Departure and Arrival station of the route can't be deleted"
    else 
      self.stations.delete(station)
      puts "From the route #{stations.first.station_name} - #{stations.last.station_name} station #{station.station_name} has been deleted "
    end
  end

  def display_stations
    puts "Route  #{stations.first.station_name} - #{stations.last.station_name} includes: "
    stations.each{|station| puts " #{station.station_name}" }
  end  
end



class Train

  attr_accessor :speed, :number, :number_of_carriages, :route, :station
  attr_reader :type

  def initialize(number, type, number_of_carriages)
    @number = number
    @type = type
    @number_of_carriages = number_of_carriages
    @speed = 0
    puts "Train № #{number} is formed. Train type: #{type}. Number of carriages: #{number_of_carriages}."
  end

  def stop 
    self.speed = 0
  end

 def acceleration(speed)
    self.speed = speed if speed > self.speed
  end

  def braking
    self.speed = 0
  end


  

  def add_carriages
    if speed.zero? 
      self.number_of_carriagest += 1
      puts "To the train №#{number} carriage was added. Now number of carrieages is #{number_of_carriages}."
    else 
      puts "While thetrain is moving carriages can't be added"
    end
  end

  def remove_carriages
    if number_of_carriages.zero?
      puts "This train do not have any carriages"
    elsif speed.zero? 
      self.number_of_carriages -= 1
      puts "From the train №#{number} carriage was removed. Now number of carrieages is #{number_of_carriages}."
    else 
      puts "While thetrain is moving carriages can't be removed"
    end
  end

  def destination(route)
    self.route = route
    puts "Train №#{number} taking rout #{route.stations.first.station_name} - #{route.stations.last.station_name}" 
  end

  def next_station(station)
    if route.nil?
      puts "Train can't be without destination'"
    elsif @station == station
      puts "Train №#{@number} already at the #{@station.station_name}"
    elsif route.stations.include?(station)
      @station.send_train(self) if @station
      @station = station
      station.get_train(self)
    else
      puts "Train №#{number} is not going through station #{station.station_name}  "
    end
  end

  def current_stations
    if route.nil?
      puts "Route is not set"
    else
      station_index = route.stations.index(station)
      puts "Train № #{number} currently at #{station.station_name}."
      puts "Previous station - #{route.stations[station_index - 1].station_name}." if station_index != 0
      puts "Next station - #{route.stations[station_index + 1].station_name}." if station_index != route.stations.size - 1
    end
  end
end
