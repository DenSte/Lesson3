class Route
    attr_accessor :stations
  
    def initialize(first_station, last_station)
      @first_station = first_station
      @last_station = last_station
    end
  
    def first_station
      station.first
    end
  
    def last_station
      station.last
    end
  
    def add_station(station)
      route.insert(-2, station)
      puts "Route from #{first_station} - to #{last_station} station #{station.name} was added"
    end
  
    def remove_station(station)
      if [first_station, last_station].include?(station)
        puts "Departure and Arrival station of the route can't be deleted"
      else
        route.delete(station)
        puts "From the route #{first_station} - #{last_station} station #{station.name} has been deleted "
      end
    end
  
    def display_stations
      puts "Route #{first_station.name} - #{last_station.name} includes: "
      stations.each { |station| puts " #{station.name}" }
    end
  end