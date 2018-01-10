# Build an inventory program for a Grocery Store. The program should allow the manager to:

# View Categories of products

# Each category by default should contain 5 items.

# View an individual product

# Change the quantity of a product

# Add products to any category.

# A product should be an object created from a class. Each category should be its own type. Each product should have the base properties of:

# name

# quantity

# serial number

# cost

# sell price

# Other features to think about:

# Add "sell by" dates to each product

# Have it so the manager can see how many items need to be sold within the week.

# List it out by product.

# Determine how much

# each product cost the store to purchase

# each product could bring in in revenue

# each product would make in profit

# Create the ability to put an item on sale, or take an item off sale. Determine the sale discount.
require 'date'

class Product
	attr_reader :serial_number,:sell_by
	attr_accessor :name, :quantity, :cost, :sell_price  

	def initialize(name,quantity,serial_number,cost,sell_price,sell_by)
		@name = name
		@quantity = quantity
		@serial_number = serial_number
		@cost = cost
		@sell_price = sell_price
		@sell_by = sell_by
		@off_sale = sell_price
	end	

	def revenue
		@sell_price * quantity
	end	

	# def add_inventory(amount)
	# 	@quantity += amount
	# end	

	# def remove_inventory(amount)
	# 	@quantity -= amount
	# end	

	def shelf_life
		if @sell_by >= Date.today
			puts "Shelflife is #{(@sell_by - Date.today).to_i} days"
		else
			puts "Item has passed it's shelflife by #{(Date.today - @sell_by).to_i} days"	
		end
	end		


	def profit
		(@sell_price * quantity) - (@cost * quantity)
	end	

	def sale(amount)
		@sell_price = amount
	end	

	def off_sale
		@sell_price = @off_sale
	end	
end


def add_products

	puts "How many products do you want to add?"
	number = gets.chomp.to_i

	number.times do
		puts "Please enter the name of your product:"
		name = gets.chomp.upcase
		puts "Please enter the quantity to add to inventory "
		quantity = gets.chomp.to_i
		puts "Please enter the serial number:"
		sn = gets.chomp.upcase
		puts "What is cost of the product"
		cost = gets.chomp.to_f
		puts "What is the sell price of the item?"
		sp = gets.chomp.to_f
		puts "What is the sell-by date of the item (YYYY-MM-DD)?"
		sb = Date.parse(gets.chomp)

		product = Product.new(name,quantity,sn,cost,sp,sb)
		@new_products.push(product)
	end	
	puts "Product(s) added."
	main_menu
end


def main_menu
	puts "Welcome to the Grocery Inventory System"
	puts "Choose an option"
	puts "----------------------------------------"
	puts "1. Enter a product"
	puts "2. View all products"
	puts "3. View/Modify product info"
	puts "4. Exit System"

	option = gets.chomp.to_i

	case option
		when 1 
			add_products
		when 2
			view_products
		when 3
		modify_product
		when 4
			puts "You are now exiting the system."
		else
		 	puts "Invalid entry"
		 	main_menu
	end	 	
end

def view_products

	if @new_products.length > 0
		@new_products.each do |n|
			puts n.name
		end
		main_menu
	else
		puts "There are no products to display."	
		main_menu
	end	
end		

def modify_product
		serial = " "
		check = false
		puts "Enter the serial number of the product you want to modify: "
		serial = gets.chomp.upcase

		@new_products.each do |n|
			if n.serial_number == serial
				check = true
			end
		end	

		if check == true
			modify_menu(serial)
		else
				puts "That serial number is not in the system."
				main_menu		
		end		

end

def modify_menu(serial)
	@new_products.each do |n|
		if n.serial_number == serial
			puts "Here are options for #{n.serial_number}(#{n.name}) "
			puts "Choose an option:"
			puts "-----------------------------------------------------"
			puts "1. View product's cost to store for purchase"
			puts "2. View product's potential revenue"
			puts "3. View product's potential profit"
			puts "4. Put an item on sale"
			puts "5. Take item off sale"
			puts "6. Determine shelf life"
			puts "7. Return to Main Menu"

			choice = gets.chomp.to_i

			if choice == 1
				puts "#{n.name}'s cost to store is #{n.cost}."
				modify_menu(serial)
			elsif choice == 2
				puts "#{n.name}'s potential revenue is #{n.revenue}."
				modify_menu(serial)
			elsif choice == 3
				puts "#{n.name}'s potential profit is #{n.profit}."
				modify_menu(serial)
			elsif choice == 4
				puts "What is the sale price?"
				sale = gets.chomp.to_f
				puts "The new price with sale is #{n.sale(sale)}"
			modify_menu(serial)
			elsif choice == 5
				puts "The sale has been removed. The original price of #{n.off_sale} is now active."	
			modify_menu(serial)
			elsif choice == 6 
				n.shelf_life
				modify_menu(serial)
			elsif choice == 7
			 	main_menu
			else
				puts "Invalid choice!"
				modify_menu(serial)
			end	 					
		end								
	end	
end






@new_products = []
main_menu




















