class A 
	def initialize
		 puts "hello"
	end
end

class B < A 

	def initalize 
		super
	end

	def methods_relevant_to_b
	end
end

class C < A 
	def initialize
		# self
		puts "no"
	end
end
class E < A 
	def self.initialize
		puts "I am E"
	end
	def some_functiom
	end
	def self.some_function
	end
end

class D < A 
end

f = A.new
g = B.new
h = C.new
i = D.new
j = E.new