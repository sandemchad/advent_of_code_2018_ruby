require_relative "solution_helper"
include SolutionHelper

def only_first_hour(time, start)
  midnight = Time.new(time.year, time.month, time.day)

  if time < midnight && time >= (midnight + 1.hour)
    start ? midnight : (midnight + 1.hour) - 1.minute
  else
    time
  end
end

def sleeps_after_midnight_array(sleep_times)
  num_of_times_asleep = Array.new(60, 0)

  sleep_times.reduce(num_of_times_asleep) do |result, (start, finish)|
    start = only_first_hour(start, true)
    finish = only_first_hour(finish, false)

    while(start < finish)
      puts start.min
      result[start.min] += 1

      start += 60
    end

    result
  end
end

def total_sleep_time_at_midnight(sleep_times)
  sleep_times.map do |(start, finish)|
    only_first_hour(finish, false) - only_first_hour(start, true)
  end.reduce(0) { |sum, i| sum + i } / 60.0
end

def solve_a(data = default_data_file(__FILE__))
  last_guard = nil

  result = data.strip.scan(/\[(\d+)-(\d+)-(\d+) (\d+):(\d+)\] (.+)/).reduce({}) do |obj, matches|
    timestamp = Time.new(*matches[0..5])
    action = matches[-1]
    guard = action.match(/Guard #(\d+) begins shift/)
    puts guard
    if guard
      last_guard = guard[1]
      obj[last_guard] = [] if obj[last_guard].nil?
    elsif action =~ /falls asleep/
      obj[last_guard] << [timestamp]
    else
      obj[last_guard].last << timestamp
    end
    obj
  end
  puts "#{result}"

  guard_sleep_times = result.to_a.reduce({}) do |obj, (id, sleep_times)|
    sleeps_after_midnight_array = sleeps_after_midnight_array(sleep_times)
    obj[id] = {
      time_asleep: sleeps_after_midnight_array.reduce(0) { |sum, i| sum + i },
      most_freqently_asleep: sleeps_after_midnight_array.index(sleeps_after_midnight_array.max),
    }

    obj
  end

  puts "#{guard_sleep_times}"

  winner = guard_sleep_times.max_by{|k,v| v[:time_asleep]}
  winner.first.to_i * winner.last[:most_freqently_asleep]
end

def solve_b(data = default_data_file(__FILE__))
  data # Unsolved
end

test_data = %Q{[1518-11-01 00:00] Guard #10 begins shift
[1518-11-01 00:05] falls asleep
[1518-11-01 00:25] wakes up
[1518-11-01 00:30] falls asleep
[1518-11-01 00:55] wakes up
[1518-11-01 23:58] Guard #99 begins shift
[1518-11-02 00:40] falls asleep
[1518-11-02 00:50] wakes up
[1518-11-03 00:05] Guard #10 begins shift
[1518-11-03 00:24] falls asleep
[1518-11-03 00:29] wakes up
[1518-11-04 00:02] Guard #99 begins shift
[1518-11-04 00:36] falls asleep
[1518-11-04 00:46] wakes up
[1518-11-05 00:03] Guard #99 begins shift
[1518-11-05 00:45] falls asleep
[1518-11-05 00:55] wakes up}

# expect(240, solve_a(test_data), test_data)

puts "\nSolution for Part A: #{solve_a}"

# expect("test", solve_b("test"), "test")

# puts "\nSolution for Part B: #{solve_b}"
