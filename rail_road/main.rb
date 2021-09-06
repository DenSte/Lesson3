require_relative 'station'
require_relative 'train'
require_relative 'route'
require_relative 'carriage'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'

stations = []
trains = []
routes =[]
CARRIAGE_TYPES = {'cargo' => CargoCarriage, 'passenger' => PassengerCarriage}


       puts %Q(
        0. Exit
        1. Create Station
        2. Create Train
        3. Create route (add/remove stations) !!!!!!!!!!!!!!!!!!!
        4. Assign route to a train !!!!!!!!!!!!!!!!!!
        5. Add carriage to a trian 
        6. Remove carriage from a train
        7. Move train within route back and forth !!!!!!!!!!!!!!!!!
        8. Send train to a station
        9. View list of stations
        10. Display train on a station
  )
 loop do
  print "Please provide a number for the action you want to perform: "
  choice = gets.chomp.to_i
  case choice

  when 0 #Exit  
    puts "Goodbye!"
    break

  when 1 #Create Station
    puts "What the name of the Station? "
    name = gets.chomp
    stations << Station.new(name)
    puts "Station #{name} has been created"

  when 2 #Create Train
    puts "What number of the train?"
    number = gets.chomp
    puts "1 - passenger, 2 - cargo"
    choice = gets.chomp.to_i
    case choice
    when 1
      trains << PassengerTrain.new(number)
      puts "Passenger train was created # #{number}"
    when 2
      trains << CargoTrain.new(number)
      puts "Cargo train was created # #{number}"
    else 
      puts "Train was not created!!! Please select option 1 or 2."
    end

  when 3 #Create route (add/remove stations)
    puts "1 - If you want to CREATE NEW route. \n"+
     "2 - If you want to ADD statiion to an existing route. \n"+
     "3 - If you want to REMOVE statiion from an existing route."
     choice = gets.chomp.to_i
    case choice
    when 1
    puts "Please provide names of the FIRST stations of the route"
    first_station = gets.chomp
    puts "Please provide names of the LAST stations of the route"
    last_station = gets.chomp

    route = Route.new(first_station, last_station)
    #Hash[route.map.with_index { |x, i| [i, x] }]
    routes << route

    puts "Route #{first_station} #{last_station} has been created"
    when 2
      puts "Please select the route from the available route list: "
      puts "List of the routes: #{routes}: "
      #route = routes.each{|rout| puts route}
      #puts "Route #{route} has been selected"
      puts "Please provide the name of the route that you want to ADD station."
      route = gets.chomp
      puts "Route #{route} has been selected"
      puts "What the name of the Station? "
      name = gets.chomp
      name.add_station
      route.add_station
      puts "Station #{name} has been added to the route #{route} "
      
    when 3

    else 
      puts "Route was not created!!! Please select option 1; 2 or 3."
    end

  #when 4 #Assign route to a train 
     #end
  when 5 #Add carriage to a trian
    if trains.empty?
      puts "First please created train"
    else 
      puts "To which train? (please provide train number)"
      number = gets.chomp
      train = trains.detect{|train| train.number == number}
      if train.nil?
        puts "There is no train with this number"
      else
        train.add_carriages(CARRIAGE_TYPES[train.type].new)
      end
    end

  when 6 #Remove carriage from a train
    if trains.empty?
      puts "First please created train"
    else 
      puts "From which train? (please provide train number)"
      number = gets.chomp
      train = trains.detect{|train| train.number == number}
      if train.nil?
        puts "There is no train with this number"
      elsif train.carriages.empty?
        puts "This train do not have any carriages"
      else 
        train.remove_carriages(train.carriages.last)
      end
    end

  #when 7 #Move train within route back and forth
  #end
  when 8 #Send train to a station
    if trains.empty?
      puts "First please created train"
    elsif stations.empty?
      puts "First please created station"
    else 
      puts "Which train? (Please provide train number)"
      number = gets.chomp
      train = trains.detect{|train| train.number == number}
      if train.nil?
        puts "There is no train with this number"
      else 
        puts "Which station? (Please provide name of the station)"
        name = gets.chomp
        station = stations.detect{|station| station.name == name}
        if station.nil?
          puts "There is no station with this name" 
        else 
          station.get_train(train)
        end  
      end
    end
  when 9 #View list of stations
    puts "Stations List:"
    stations.each{|station| puts station.name}
  
  when 10 #Display train on a station
    if stations.empty?
      puts "First please created station"
    else
      puts "Which station? (Please provide name of the station)"
      name = gets.chomp
      station = stations.detect{|station| station.name == name}
      if station.nil?
        puts "There is no station with this name"
      else 
        station.show_trains
      end
    end
  else
    puts "Please select one option from the list"
  end
end
