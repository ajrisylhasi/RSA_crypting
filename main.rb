require_relative 'helper'
loop do
	puts "RSA Program"
	puts "<================================>"
	puts 
	loop do
		puts "1: Encrypt"
		puts "2: Decrypt"
		puts "3: Generate Keys"
		puts "0: Leave"
		puts
		print "Choose with a number: "
		ans = gets.chomp.to_i
		puts 
		if !([1, 2, 3, 0].include? ans)
			puts "Choose the right numbers"
			puts 
		else
			break
		end
	end
	if ans == 1
		encrypt_message()
	elsif ans == 2
		decrypt_message()
	elsif ans == 0
		break
	else
		n, e, d = generate_keys(1024)
		print_keys(n, e, d)
	end
	puts 
end
