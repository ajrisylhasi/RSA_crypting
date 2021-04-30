def extended_eucleadian_algorithm(pp, q)
    if pp == 0
    	return q, 0, 1
    else
    	gcd, x, y = extended_eucleadian_algorithm(q % pp, pp)
    	return gcd, y - (q / pp) * x, x
    end
end

def modular_inverse_algorithm(a, b)
    return extended_eucleadian_algorithm(a, b)[1]
end

def fast_modular_exponentiation(a, b, m)
    y = 1
    while b > 0 do
    	if b % 2 == 0
    		a = (a * a) % m
    		b = b/2
    	else
    		y = (a * y) % m
    		b = b - 1
    	end
    end
	return y
    
end

def chinese_remainer_theorem(c,pp, q, d)
    dp = d % (p-1)
    dq = d % (q-1)
    mp = fast_modular_exponentiation(c, dp, p)
    mq = fast_modular_exponentiation(c, dq, q)
    _, yp,yq = extended_eucleadian_algorithm(p, q)
    return ((mp * q * yq) + (mq * p * yp)) % (p * q)
end

def miller_rabin_algorithm(n)
	k = 5
    pp = n-1
    s = 0
    while ((pp % 2 ) != 0 ) do
    	pp = pp.div(2)
    	s += 1
    end
    if fast_modular_exponentiation(k, pp, n) == 1
    	return true
    else
    	(1...s).each do |i|
    		if n - 1 == k.pow((2.pow(i) * pp))
    			return true
    		end
    	end
    	return false
    end
    return false
end

def get_superlarge_rand(input_n_digit)
      smallest_number_of_nplus1_digits = 10**input_n_digit
      smallest_number_of_n_digits = 10**(input_n_digit-1)
      random_n_digit_number = Random.rand(smallest_number_of_nplus1_digits-smallest_number_of_n_digits)+smallest_number_of_n_digits
      return random_n_digit_number
end

def get_superlarge_prime(b)
    while true do
    	pp = get_superlarge_rand(b)	
    	primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239,
    		241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503, 509, 521, 523, 541]
		bool = false
		for x in primes do 
			if pp % x == 0
				bool = true
			end
		end
		if bool
			next
		end
		# puts "here"
		if miller_rabin_algorithm(pp)
			return pp
		end
    end
end

def generate_keys(b)
	puts "Generating very long (1024 bits) random prime p..."
    pp = get_superlarge_prime(b)
    puts "Generating very long (1024 bits) random prime q..."
    q = get_superlarge_prime(b)
    e = 3
    n = pp*q
    pi_n = (pp-1)*(q-1)
    while !(extended_eucleadian_algorithm(e, pi_n)[0] == 1) do
    	e = e+1
    end
    d = modular_inverse_algorithm(e, pi_n) % pi_n
    return n, e, d
end


def encrypt(keys, message)
    e, n = keys
    result = []
    message.split("").each do |c|
    	result << fast_modular_exponentiation(c.ord, e, n).to_s
    end
    return result.join " "
end


def decrypt(keys, cipher)
	begin
	    d, n = keys
	    result = []
	    for c in cipher.split(' ') do 
	    	result << fast_modular_exponentiation(c.to_i, d, n).chr
	    	
	    end
	    return result.join ""
	rescue RangeError => e
		puts 
		puts "<====================================>"
        puts "Not the right keys"
        puts "<====================================>"
        return nil
	end
end

def encrypt_message
    print "Enter your message: "
    message = gets.chomp
    puts "Enter Public Key"
    print "Enter e: "
    e = gets.chomp.to_i
    print "Enter n: "
    n = gets.chomp.to_i
    cipher = encrypt([e, n], message)
    puts 
    puts "<====================================>"
    puts "Cipher: #{cipher}"
    puts "<====================================>"
end

def decrypt_message
    puts "Enter the cipher:"
    cipher = gets.chomp
    puts "Enter Private Key"
    print "Enter d: "
    d = gets.chomp.to_i
    print "Enter n: "
    n = gets.chomp.to_i
    message = decrypt([d, n], cipher)
    if message
	    puts
	    print "The message is: "
	    puts message
	end
end
def print_keys(n, e, d)
	puts 
    puts "Public Key: "
    puts "<====================================>"
    puts "n -> "+ n.to_s
    puts "<====================================>"
    puts 
    puts "<====================================>"
    puts "e -> "+ e.to_s
    puts "<====================================>"
    puts 
    puts "Private Key:"
    puts "<====================================>"
    puts "d -> "+ d.to_s
    puts "<====================================>"
end
