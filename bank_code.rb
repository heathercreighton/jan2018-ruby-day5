class Account
	attr_accessor :name, :account_num, :balance
	def initialize(name, account_num, balance)
		@name = name
		@account_num = account_num 
		@balance = balance
	end

	def deposit(amount)
		@balance += amount
	end	

	def withdrawal(amount)
		if @balance < amount
			return false #checks to make sure there is enough available
		else
			return @balance -= amount
		end		
		
	end	
end		



def main_menu
	puts "Welcome to Creighton Bank"
	puts "Please choose an option:"
	puts "--------------------------"
	puts "1. Create a new account"
	puts "2. View an existing account"
	puts "3. Exit Program"

	option = gets.chomp.to_i

	if option == 1
	  create_account
	  main_menu
	elsif option == 2
		if @accounts.length == 0
			puts "There are no accounts yet."
			main_menu
		else
	  	account_login
	  end	
	elsif option == 3
	 	puts "Thank you for visiting Creighton Bank!"
	 	exit
	else
		puts "Please choose a valid option."  
		main_menu	
	end	
end

def create_account

	puts "Please enter the name of the account holder:"
	name = gets.chomp.upcase
	puts "Please enter the starting balance"
	balance = gets.chomp.to_f
	account_number = @accounts.length + 1
	new_account = Account.new(name, account_number, balance)
	@accounts.push(new_account)

	puts "Account #{account_number} for #{name} has been created with a starting balance of $#{'%.2f' %(balance)}."

	puts @accounts.inspect
end	


def account_login
	found = false
	tries = 0
	while tries < 3 
		puts "Please enter the name of the account"
		name = gets.chomp.upcase
		puts "Please enter the account number:"
		acct_num = gets.chomp.to_i
			
				
			@accounts.each do |account|
				if account.name == name && account.account_num == acct_num
					found = true
					tries = 3
				else 
					puts "Account not found please try again."
				end 		 	
			end
		tries +=1	
	end

	if found == false
			puts "Sorry you are having issues.  Please contact customer service"
			main_menu
	else
			account_menu(name, acct_num)		
	end			

end	


def account_menu(name, account_number)
	puts "Welcome #{name} to your account menu."
	puts "Please make a selection:"
	puts "-------------------------------------"
	puts "1. View Balance"
	puts "2. Make a deposit"
	puts "3. Make a withdrawal"
	puts "4. Return to main menu"

	choice = gets.chomp.to_i

	if choice == 1
		view_balance(name, account_number)
	elsif choice == 2
		make_deposit(name, account_number)
	elsif choice == 3
		make_withdrawal(name, account_number)
	elsif choice == 4
	 	main_menu
	else
		puts "Please make a valid choice!"	
		account_menu(name, account_number)
 	end
end	



def view_balance(name, account_number)
	@accounts.each do|account|
		if account.name == name && account.account_num == account_number
			puts "Your account balance is $#{'%.2f' %(account.balance)}"
		end
	end		
account_menu(name, account_number)
end	

def make_deposit(name, account_number)
	puts "How much would you like to deposit?"
	dep_amount = gets.chomp.to_f


	@accounts.each do |account|
		if account.name == name && account.account_num == account_number
				puts "Your current account balance is $#{'%.2f' %(account.balance)}"
				account.deposit(dep_amount)
				puts "Your deposit of $#{'%.2f' %(dep_amount)} has been made."
				puts "Your new balance is $#{'%.2f' %(account.balance)}. "
		end
	end	
	account_menu(name, account_number)
end	

def make_withdrawal(name, account_number)
	puts "How much would you like to withdraw?"
	withdrawal_amount = gets.chomp.to_f

	@accounts.each do |account|
		if account.name == name && account.account_num == account_number
			puts "Your current account balance is $#{'%.2f' %(account.balance)}"
			if account.withdrawal(withdrawal_amount) == false
				puts "Insufficient balance for withdrawal amount requested."
				account_menu(name, account_number)
			else 
				puts "Your withdrawal of $#{'%.2f' %(withdrawal_amount)} has been made."
				puts "Your new account balance is $#{'%.2f' %(account.balance)}."
			end		
		end	
	end	
	account_menu(name, account_number)
end	