require_relative "solution_helper"
include SolutionHelper

def solve_a(data = default_data_file(__FILE__))

end

def solve_b(data = default_data_file(__FILE__))
  data # Unsolved
end

expect("test", solve_a("test"), "test")

puts "\nSolution for Part A: #{solve_a}"

expect("test", solve_b("test"), "test")

puts "\nSolution for Part B: #{solve_b}"
