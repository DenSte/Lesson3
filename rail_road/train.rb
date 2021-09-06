class Train
    attr_accessor :speed, :number, :route, :station, :carriages
    attr_reader :type
  
    def initialize(number, type)
      @number = number
      @type = type
      @carriages = []
      @speed = 0
      @current_station_index = 0
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
  
    def add_carriages (carriage)
      if speed.zero?
        self.carriages << carriage
        puts "To the train №#{number} carriage was added."
      else
        puts "While the train is moving carriages can't be added"
      end
    end
  
    def remove_carriages (carriage)
      if !carriages.include?(carriage)
        puts 'This train do not have any carriages'
        elsif speed.zero? 
        self.carriages.delete(carriage)
        puts "From the train №#{number} carriage was removed."
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