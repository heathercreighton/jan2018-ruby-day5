#class to define our employee record object and methods
class Employee
	attr_accessor :name, :role, :location, :employee_number

	def initialize(name, role, location, employee_number)
		@name = name
		@role = role
		@location = location
		@employee_number = employee_number
	end	

	def change_role(new_role) 
		@role =  new_role
	end
	

	def change_location(new_location)	
		@location = new_location
	end	

end	

#main menu of our program
def main_menu
	puts "Welcome to the Employee Records"
	puts "--------------------------------"
	puts "1. Enter new employee"
	puts "2. View existing employee record"
	puts "3. View All Employees"
	puts "4. Exit System"

	option = gets.chomp.to_i

	if option == 1
	 create_employee
	 main_menu
	elsif option == 2
		view_employee
	elsif option == 4
		puts "You are now exiting the Employee Records"
		exit
	elsif option == 3
		puts "View All Employees"
		all_employees
		main_menu
	else
		puts "Invalid Entry. Please try again."
		main_menu
						
	end
end

#creates an employee record based on the input from the user. Assigns employee number based on length of employee array
def create_employee
	print "Please enter the name of the employee: "
	name = gets.chomp.upcase
	print "Please enter the employee's role: "
	role = gets.chomp.upcase
	print "Please enter the employee's location: "
	location = gets.chomp.upcase
	employee_number = @employees.length + 1

#creates new employee instance and store the values of the objects in an instance array called @employees
	new_employee = Employee.new(name, role, location, employee_number)
	@employees.push(new_employee)

	puts "Employee record has been created: "
	puts "Name - #{new_employee.name}"
	puts "Role - #{new_employee.role}"
	puts "Location - #{new_employee.location}"
	puts "Employee No. - #{new_employee.employee_number}"


end


def view_employee
	print "Enter employee name: "
	name = gets.chomp.upcase
	print "Enter employee number: "
	employee_number = gets.chomp.to_i

	#set a check value to false, if record is found in array, the check value changes to true.
	found = false

	@employees.each do |e|
		if e.name == name && e.employee_number == employee_number
			found = true
			break
		else 
			@count +=1	
		end
	end		

#Gives user 3 chances to find the record before being returned to the main menu
	if found == true
		puts "Employee record has been found!"
		employee_menu(name, employee_number)

	else
		if @count < 3
				puts "Employee number not found.  Please try again."
				puts "Attempt number #{@count}"
				view_employee	
		else
			puts 	"Please contact the system administrator."
			main_menu
		end	
	end	
end


def employee_menu(name, employee_number)
	puts "Employee Menu"
	puts "----------------------"
	puts "1. View employee record"
	puts "2. Modify employee role"
	puts "3. Modify employee location"
	puts "4. Return to Main Menu"


	option = gets.chomp.to_i
	if option == 1
		view_record(name, employee_number)
		employee_menu(name, employee_number)
	elsif option == 2
		modify_role(name, employee_number)
		employee_menu(name, employee_number)
	elsif option == 3
		modify_location(name, employee_number)
		employee_menu(name, employee_number)
	elsif option == 4
		puts "Exiting the Employee Menu"
		main_menu

	else
		puts "Invalid Entry.  Try again!"	
		employee_menu(name, employee_number)
	end	

end	

def view_record(name, employee_number)
	@employees.each do |e|
		if e.name == name && e.employee_number == employee_number
			puts "Employee Name: #{e.name}"
			puts "Employee Number: #{e.employee_number}"
			puts "Employee Role: #{e.role}"
			puts "Employee Location: #{e.location}"

		end		
	end	
end	





def modify_role(name, employee_number)
	print "Enter the employees new role: "
	new_role = gets.chomp.upcase

	@employees.each do |e|
		if e.name == name && e.employee_number == employee_number
			puts "Employees Previous Role: #{e.role}"
			puts "Employees New Role: #{e.change_role(new_role)}"	
		end
	end		
end	


def modify_location(name, employee_number)
	print "Enter the employees new location: "
	new_location = gets.chomp.upcase

	@employees.each do |e|
		if e.name == name && e.employee_number == employee_number
			puts "Employees Previous Location: #{e.location}"
			puts "Employees New Location: #{e.change_location(new_location)}"	
		end
	end		
end	



def all_employees
	if @employees.length != 0
		@employees.each do |e|
			puts e.name, e.role, e.location
		end		

	else
		puts "There are no employees in the database."
		main_menu
	end	
end


# Main program
@count = 0
@employees = []
main_menu