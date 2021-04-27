require_relative 'helper'
loop do
	puts "RSA Program"
	puts "<================================>"
	puts 
	inputted_value = 0
	loop do
		puts "1: Encrypt"
		puts "2: Decrypt"
		puts "3: Generate Keys"
		puts "0: Leave"
		puts
		print "Choose with a number: "
		inputted_value = gets.chomp.to_i
		puts 
		if !([1, 2, 3, 0].include? inputted_value)
			puts "Choose the right numbers"
			puts 
		else
			break
		end
	end
	if inputted_value == 1
		encrypt_message()
	elsif inputted_value == 2
		decrypt_message()
	elsif inputted_value == 0
		break
	else
		n, e, d = generate_keys(1024)
		print_keys(n, e, d)
	end
	puts 
end
