# frozen_string_literal: true

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

  def strains_by_type(type)
    puts "Trains at the #{name} type #{type}: "
    trains.each { |train| puts train.number if train.type == type }
  end

  def send_train(train)
    trains.delete(train)
    train.station = nil
    puts "From the station #{name} departure train № #{train.number}"
  end
end

class Route
  attr_accessor :stations

  def initialize(from, to)
    @stations = [from, to]
    puts "Route from #{from.name} to #{to.name}"
  end

  def first_station
    station.first
  end

  def last_station
    station.last
  end

  def add_station(station)
    stations.insert(-2, station)
    puts "Route from #{first_station.name} - to #{last_station.name} station #{station.name} was added"
  end

  def remove_station(station)
    if [first_station, last_station].include?(station)
      puts "Departure and Arrival station of the route can't be deleted"
    else
      stations.delete(station)
      puts "From the route #{first_station.name} - #{last_station.name} station #{station.name} has been deleted "
    end
  end

  def display_stations
    puts "Route #{first_station.name} - #{last_station.name} includes: "
    stations.each { |station| puts " #{station.name}" }
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
    @current_station_index = 0

    puts "Train № #{number} is formed. Train type: #{type}. Number of carriages: #{number_of_carriages}."
  end

  def stop
    self.speed = 0
  end

  def accelerate(speed)
    self.speed = speed if speed > self.speed
  end

  def brake
    self.speed = 0
  end

  def add_carriages
    if speed.zero?
      self.number_of_carriagest += 1
      puts "To the train №#{number} carriage was added. Now number of carrieages is #{number_of_carriages}."
    else
      puts "While the train is moving carriages can't be added"
    end
  end

  def remove_carriages
    if number_of_carriages.zero?
      puts 'This train do not have any carriages'
      elseif speed.zero?
      self.number_of_carriages -= 1
      puts "From the train №#{number} carriage was removed. Now number of carrieages is #{number_of_carriages}."
    else
      puts "While the train is moving carriages can't be removed"
    end
  end

  def set_rout(route)
    self.route = route
    @current_station_index = 0
    puts "Train №#{number} taking rout #{route.first_station.name} - #{route.last_station.name}"
  end

  def go_next_station
    @current_station_index += 1 if @current_station_index != @current_station_index.last && !@current_station_index.nil?
  end

  def go_previous_station
    if @current_station_index.positive? != @current_station_index.first && !@current_station_index.nil?
      @current_station_index -= 1
    end
  end

  def nearest_stations_list(route)
    stations = route.stations
    { previous_station: stations[@current_station_index -= 1], current_station_index: [@current_station_index],
      next_station_index: [@current_station_index += 1] }
  end
end
