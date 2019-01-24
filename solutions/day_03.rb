require_relative "solution_helper"
include SolutionHelper
start = Time.now
def parse_claim(claim)
  claim.strip.match(/\#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/).to_a[1..-1].map(&:to_i)
end

def add_claim(grid, claim)
  id, x_pos, y_pos, width, height = parse_claim(claim)

  width.times do |i|
    height.times do |j|
      x = x_pos + i
      y = y_pos + j

      grid[x][y] << id
    end
  end

  grid
end

def create_grid(data)
  grid = Array.new(1000) { Array.new(1000) { [] } }

  data.split("\n").reduce(grid) { |result, claim| add_claim(result, claim) }
end

def solve_a(data = default_data_file(__FILE__))
  create_grid(data).reduce(0) do |result, row|
    result + row.count { |ids| ids.count > 1 }
  end
end

def solve_b(data = default_data_file(__FILE__))
  res = create_grid(data).reduce(Hash.new { |h, k| h[k] = [] }) do |result, row|
    row.select(&:any?).reduce(result) do |obj, ids|
      ids.each { |id| obj[id] << ids.length }

      obj
    end
  end

  res.detect { |_id, layers| layers.uniq.count == 1 && layers[0] == 1 }.first
end

# test_a = "#1 @ 1,3: 4x4\n#2 @ 3,1: 4x4\n#3 @ 5,5: 2x2"
# expect(4, solve_a(test_a), test_a)
# test_b = "#1 @ 1,3: 4x4\n#2 @ 3,1: 4x4\n#3 @ 4,4: 2x2"
# expect(6, solve_a(test_b), test_b)

puts "\nSolution for Part A: #{solve_a}"

# expect(3, solve_b(test_a), test_a)

puts "\nSolution for Part B: #{solve_b}"

# code to time
finish = Time.now
puts "Time taken: #{finish - start}"
