require_relative "solution_helper"
include SolutionHelper

def solve_a(data = default_data_file(__FILE__))
  data.split(" ").reduce(0) { |o, s| o.send(s[0], s[1..-1].to_i) }
end

def solve_b(data = default_data_file(__FILE__))
  history = [0]
  loop do
    data.split(" ").reduce(history.last) do |obj, change|
      result = obj.send(change[0], change[1..-1].to_i)

      return result if history.include?(result)
      history << result

      result
    end
  end
end

expect(3, solve_a("+1 +1 +1"), "+1 +1 +1")
expect(0, solve_a("+1 +1 -2"), "+1 +1 -2")
expect(-6, solve_a("-1 -2 -3"), "-1 -2 -3")

puts "\nSolution for Part A: #{solve_a}"

expect(0, solve_b("+1 -1"), "+1 -1")
expect(10, solve_b("+3 +3 +4 -2 -4"), "+3 +3 +4 -2 -4")
expect(5, solve_b("-6 +3 +8 +5 -6"), "-6 +3 +8 +5 -6")
expect(14, solve_b("+7 +7 -2 -7 -4"), "+7 +7 -2 -7 -4")

puts "\nSolution for Part B: #{solve_b}"
