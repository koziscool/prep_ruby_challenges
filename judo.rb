
#needs exp to be an integer

def power( base, exp )
    result = 1
    for i in 1..exp
        result *= base
    end
    result
end

puts power( 3, 4 )

def factorial( n )
    result = 1
    for i in 1..n
        result *= i
    end
    result
end

puts factorial(5)

def uniques( arr )
  count_hash = Hash.new(0)
  ret_arr = []
  arr.each do |elt|
    count_hash[elt] += 1
    ret_arr << elt if count_hash[elt] == 1
  end

  ret_arr
end

print uniques([1,5,'frog', 2,1,3,'frog'])
puts

#is assuming elts are strings per instructions

def combinations( arr1, arr2 ) 
    ret_arr = []
    arr1.each do |elt1|
        arr2.each do |elt2|
            ret_arr << elt1 + elt2
        end
    end
    ret_arr
end

print combinations(['on','in'],['to','rope'])
puts

def is_prime?( n )

    def primesUpTo( limit )
        primes = [2, 3, 5, 7]

        for i in 10...limit
            prime_flag = true
            primes.each do |p|
                if i % p == 0
                    prime_flag = false
                    break
                end
                break if p ** 2 > i
            end
            primes << i if prime_flag
        end

        primes
    end

    limit  = Math.sqrt(n).floor
    primes = primesUpTo( limit )

    return true if primes.include? n

    primes.each do |p|
        return false if  n % p == 0
    end
    true

end

puts is_prime?(7)
puts is_prime?(14)
puts is_prime?( 135577 )
puts is_prime?(  999983 ) 

#rect 1 & 2 are 2x2 arrays of integers, probably need to define well-formed rectangles too
def overlap( rect1, rect2 )
    intersection_min_x = [ rect1[0][0], rect2[0][0] ].max
    intersection_min_y = [ rect1[0][1], rect2[0][1] ].max
    intersection_max_x = [ rect1[1][0], rect2[1][0] ].min
    intersection_max_y = [ rect1[1][1], rect2[1][1] ].min

    #print [ [intersection_min_x, intersection_min_y], [intersection_max_x, intersection_max_y] ]
    intersection_max_x > intersection_min_x && intersection_max_y > intersection_min_y
end

puts overlap( [ [0,0],[3,3] ], [ [1,1],[4,5] ] )
puts overlap( [ [0,0],[1,4] ], [ [1,1],[3,2] ] )


def counting_game( num_players, last_number )

    def full_cycle( the_hash )

        def new_number( the_hash )
            n = the_hash['current_number'] += 1
            if n % 11 == 0
                the_hash['skip_player'] = true
            else
                the_hash['skip_player'] = false
            end
        end

        def increment_player( the_hash )
            if the_hash['current_player'] < the_hash[ 'num_players' ]
                the_hash['current_player'] += 1
            else
                the_hash['current_player'] = 1
            end
        end

        def decrement_player( the_hash )
            if the_hash['current_player'] == 1
                the_hash['current_player'] = the_hash[ 'num_players' ]
            else
                the_hash['current_player'] -= 1
            end                
        end

        def new_player(the_hash)
            if the_hash['direction'] == 'up'
                increment_player( the_hash )
                increment_player( the_hash ) if the_hash['skip_player']
            else
                decrement_player( the_hash )
                decrement_player( the_hash ) if the_hash['skip_player']
            end
        end

        def new_direction(the_hash)
            if the_hash['current_number'] % 7 == 0
                if the_hash['direction'] == 'up'
                    the_hash['direction'] = 'down'
                else
                    the_hash['direction'] = 'up'
                end
            end
        end

        new_player(the_hash)
        new_number(the_hash)
        new_direction(the_hash)
       
    end

    def write_to_screen( the_hash )
        # print the_hash
        # puts
    end

    game_hash = {
        'current_number' => 1,
        'current_player' => 1,
        'direction' => 'up',
        'skip_player' => false,
        'num_players' => num_players
    }

    write_to_screen( game_hash )
    while game_hash['current_number'] < last_number
        full_cycle( game_hash )
        write_to_screen( game_hash )
    end

    game_hash['current_player']
end 

puts "The current player is: " + counting_game( 10, 100 ).to_s

