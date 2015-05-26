class Player 
	attr_accessor :age , :fitness, :street_smarts, :clothing, :money, :location, :gang, :friends, :weapons, :nationality, :arrested, :stash , :current_city
	
	def initialize(args)
		args = defaults.merge(args)
		@age = 			 args[:age] 
		@fitness = 		 args[:fitness]
		@street_smarts = args[:street_smarts]
		@clothing = 	 args[:clothing]
		@money = 		 args[:money]
		@current_city =  args[:current_city]
		@gang = 		 args[:gang]
		@friends = 		 args[:friends]
		@weapons = 		 args[:weapons]
		@nationality = 	 args[:nationality]
		@arrested = 	 args[:arrested]
		@stash = 		 args[:stash]
	end

	def defaults 
		{:age => 24, 
		:fitness => 5,
		:street_smarts => 5 , 
		:clothing => "Standard",
		:money => 100.00, 
		:location => "Home", 
		:gang => "Bloods",
		:friends => 5,
		:weapons => "knife", 
		:nationality => "American", 
		:arrested => false, 
		:stash => 5, 
		:current_city =>"NYC" }
	end
	def buy_food
		money -= 1 
	end

	def eat
		fitness += 1
	end

	def workout
		fitness += 1 
	end
	
	def move_cities
		current_city = City.new #random name) 
		##dependency. Player should not need to know the name of the City class
	end
	
	def buy_drugs
		stash += Drugs.new.name  
		money -= 1
	end

	def fight
		if weapon == "nothing"
			puts "you lose"
		elsif weapon == "knife"
				puts "you stabbed him"
		end
		# gets
		# @button <=> @other_button
		#in a fight in a multiplayer game, you can make the fightdepend on who
		#pressed "a" the most times in a period. If you did, you're string
		#would be longer and you would be declared the winner
	end

	def run_away
	end

	def rolls_with_gang?
		return true if gang.include?["real_nigga"] 
	end

	# def say_watup
		# puts "say hello"
		# greeting = gets.chomp
			# case greeting
			# when "Asian"
			# 	puts "hello".tr_s('l','rrr')
			# else "Jamaican"
			# 	puts "eyyy wassup mon" 
			# end
	# end

	def got_arrested?
		return arrested = true
	end
end


class Dealer < Player
	attr_accessor :hustle_factor, :name, :drug 
	
	def initiailize 
		super()
		@hustle_factor = hustle_factor
		@drug = Drugs.new(price, type)
	end


	# Drugs = Struct.new (:price, :type) do
		def	hustle  	 	
		end

		def sell_drugs
			stash -= Drug.amount 
			money += Drug.price 
		end
	# end
	def run_away?()
		if hustle_factor == 0 
			return true 
		elsif hustle_factor > 10 && hustle_factor < 20
			 puts "Do you want to run away?"
			 ans = gets.chomp
			 return true if ans == ["yes","y"]
		else 
			puts "Man Shut the Hell Up I ain't going nowhere"
		end
	end

	def bribe
		 money -= 1 unless got_arrested?
		 ##should not need to know name of get_arrested? method 
	end
end

class Cop < Player
	attr_accessor :corruption_level
	
	def initialize
		super()
		@corruption_level = corruption_level
	end
	
	 def arrest(player)
		player.arrested = true
	end 
end

class City
	attr_accessor :name, :size, :lawfulness, :crime_rate, :drugs
	def initialize
	 @name = name
	 @size = size #sqft
	 @lawfulness = lawfulness #1-10
	 @crime_rate = crime_rate #1-10
	 @drugs = Drugs.new(type,price,legality)
	end

	def get_drug_price
		puts "#{drugs.price}"  
	end

	def get_drug_type
		puts "#{drugs.type}"
	end

	def get_drug_legality
		puts "#{drugs.legality}"
	end

	#mugged should really be in a different class. Cities don't mug people
	def probability_mugging_factor()
		if crime_rate > 5 
			rand = Math.rand(1..10)
				if rand == 4
					player.money -= 1 if @player.money != 0 
					player.stash -= 1 if @player.stash != 0
				end
		end
	end
end

class Drugs
	attr_accessor :type, :price, :legality
	
	def initialize 
		@type, @price, @legality = type, price, legality
	end

	def character_effect
		case 
		when Marijuana
			@player.street_smarts -= 1 
			@dealer.hustle_factor -= 1
			@player.friends += 1 
			@player.weapons -= 1 
		when PCP 
			@player.street_smarts += 1 
			@player.hustle_factor += 3 
			@player.friends -= 1 
			@player.weapons +=	1
		when Heroin 
			@player.street_smarts -= 3 
			@player.hustle_factor -= 3 
			@player.friends -= 2 
			@player.weapons -=	2	
		when LSD 
			@player.street_smarts += 1 
			@player.hustle_factor -= 1 
			@player.friends += 3 
			@player.weapons -=	1
		when Mushrooms 
			@player.street_smarts -= 1 
			@player.hustle_factor -= 2 
			@player.friends += 3 
			@player.weapons -=	1
		end 	
	end
end
	class Food 
		attr_accessor :type 
		
		def initialize 
			@type = {}
		end
	end

####################################

p = Player.new 
p.age = 21 
p.fitness = "high"
p.street_smarts = 8
p.clothing = "swag"
p.money = 2000
p.location = "NYC"
p.weapons = "knife"
p.arrested = false
p.move_cities

d = Dealer.new
d.name = "Jaekwongi"
d.hustle_factor = 16

c=Cop.new
c.corruption_level = 0

# city = City.new
puts p.inspect
puts d.inspect
# puts d.instance_of? City
# puts p.instance_of? City