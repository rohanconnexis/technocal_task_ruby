class Slot
  def create_slot    
    puts "Please enter in which method you want to continue"
    puts "1. using file input"
    puts "2. using interactive prompt"
    option = gets.chomp
    if option.to_i == 2 
      slots = []
      puts "Please enter how many slots to create"
      num_slots = gets.chomp
      temp_val = num_slots.to_i
      num_slots.to_i.times do
        slots << temp_val
        temp_val -= 1
      end
      puts "created #{slots} "
      slots.sort
    elsif option.to_i == 1
      puts "Please enter a file name"
      inp_file = gets.chomp
      read_file(inp_file)
    end    
  end

  def read_file(file_name)
    count = 0
    arr = []
    car_hash = {}
    slots = []
    reg_no_color = []
    File.open(file_name, "r") do |f|
      f.each_line do |line|
        arr = line.split(" ")
        if(arr[0] == "create_parking_lot​")
          puts "creating slots"
	  num_of_slots = line.split(" ").last.to_i
	  slots = create_slots_from_file(num_of_slots)
	end
	if(arr[0] == 'park​')
	  puts "add to hash............"+ line.split(" ")[2]
	   reg_no_color << line.split(" ")[2]
	   reg_no_color << line.split(" ")[4]
	  add_to_hash(reg_no_color, car_hash, count)
	end
	if(arr[0] == 'leave​')
	  puts "empty the slot"
	  slot_no = line.split(" ")[2]
	  slot_to_free(slot_no, car_hash)
	end
	if(arr[0] == 'slot_numbers_for_cars_with_colour​')
	  puts "slot_numbers_for_cars_with_colour............................"
	  reg_no = line.split(" ")[2]
	  find_slot_for_registration_no(reg_no, car_hash,slots)
	end
	if(arr[0] == 'registration_numbers_for_cars_with_colour​')
	  puts "registration_numbers_for_cars_with_colour.................."
	  color = line.split(" ")[4]
	  get_list_of_registration_nos(color, car_hash)
	end
	if(arr[0] == 'status')
	  puts "print table "
        end
      end
    end
  end

  def add_to_hash(reg_no_color, car_hash, count)
    car_hash[count+1] = reg_no_color
  end

  def create_slots_from_file(num_of_slots)
    slots = []
    temp_val = num_of_slots
      num_of_slots.to_i.times do
        slots << temp_val
        temp_val -= 1
      end
      puts "created lot of slots #{slots} "
      slots.sort
  end

  def find_slot_for_registration_no(reg_no, slot_hash,num_of_slots)
     print_slot(reg_no, slot_hash)
  end

  def print_slot(reg_no, slot_hash)
     slot_hash.each do |key,value|
       if value.include? reg_no
         puts "Alloated slot no #{key}"
       end
     end
   end

  def get_list_of_registration_nos(color, slot_hash)
    slot_hash.each do |key,value|
       if value.include?("'#{color}'")
         puts "#{value[0]}"
       end
     end
  end

  def print_table(car_hash)
    puts "Slot No." + "     " + "Registration​ ​ No." + "     " + "Color" 
    cars.each do |key, value|
      puts "#{key}" + "     " +  "#{value[0]}" + "     " + "#{value[1]}"
    end
  end

  def slot_to_free(slot_no, cars)
    cars[slot_no] = ''
    puts "Slot #{slot_no} is free "
  end
end

class Car
  def get_car_color_and_registration_no(num_of_slots)
    cars = {}
    num_of_slots.each do |slot|
      puts slot
      puts "Please enter car registration"
      car_registration_no = gets.chomp
      puts "please enter car color"
      car_color = gets.chomp
      temp_array = []
      temp_array << car_registration_no
      temp_array << car_color
      cars[slot] = temp_array	
    end
    cars
  end


   def find_slot_for_registration_no(reg_no, slot_hash,num_of_slots)
     print_slot(reg_no, slot_hash)
     num_of_slots.each do |slot|
       puts "Do you want to continue search? "
       puts "1; Yes"
       puts "2: No"
       search = gets.chomp.to_i
       if search == 1
         print_slot(reg_no, slot_hash)
	else
	  break;
	end
     end
     
  end

   def print_slot(reg_no, slot_hash)
     slot_hash.each do |key,value|
       if value.include? reg_no
         puts "Alloated slot no #{key}"
       end
     end
   end

  def slot_to_free(slot_no, cars)
    cars[slot_no] = ''
    puts "Slot #{slot_no} is free "
  end

  
  def print_table(cars)
    puts "Slot No." + "     " + "Registration​ ​ No." + "     " + "Color" 
    cars.each do |key, value|
      puts "#{key}" + "     " +  "#{value[0]}" + "     " + "#{value[1]}"
    end
  end

  def get_list_of_registration_nos(color, slot_hash)
    slot_hash.each do |key,value|
       if value.include?("'#{color}'")
         puts "#{value[0]}"
       end
     end
  end
end


obj1 = Slot.new
num_of_slots = obj1.create_slot
obj2 = Car.new
cars = obj2.get_car_color_and_registration_no(num_of_slots)
puts "please enter registration no to find the slot"
reg_no = gets.chomp
obj2.find_slot_for_registration_no(reg_no, cars, num_of_slots)
puts "Please enter slot number to free"
slot_no = gets.chomp
obj2.slot_to_free(slot_no, cars)
obj2.print_table(cars)
puts "Please enter car color to get list of registration nos."
color = gets.chomp
obj2.get_list_of_registration_nos(color, cars)



