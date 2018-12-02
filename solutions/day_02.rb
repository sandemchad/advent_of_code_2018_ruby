require_relative "solution_helper"
include SolutionHelper

def solve_a(data = default_data_file(__FILE__))
  twos, threes = data.split(" ").reduce([0, 0]) do |(a, b), id|
    freq = id.split("").reduce(Hash.new(0), &method(:freq))

    [
      a + (freq.detect { |_, v| v == 2 } ? 1 : 0),
      b + (freq.detect { |_, v| v == 3 } ? 1 : 0),
    ]
  end

  twos * threes
end

def solve_b(data = default_data_file(__FILE__))
  data.split(" ").combination(2) do |a, b|
    match = a.each_char.with_index.reduce("") do |str, (char, index)|
      char == b[index] ? (str + char) : str
    end

    return match if match.length == (a.length - 1)
  end
end

expect(12, solve_a("abcdef bababc abbcde abcccd aabcdd abcdee ababab"), "abcdef bababc abbcde abcccd aabcdd abcdee ababab")

puts "\nSolution for Part A: #{solve_a}"

expect("fgij", solve_b("abcde fghij klmno pqrst fguij axcye wvxyz"), "abcde fghij klmno pqrst fguij axcye wvxyz")

puts "\nSolution for Part B: #{solve_b}"
