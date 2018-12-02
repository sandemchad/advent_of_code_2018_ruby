module SolutionHelper
  def expect(expected, actual, input)
    if expected == actual
      # puts "Passed with input: '#{input}'"
      print "."
    else
      puts "\nUhoh Failed on input: '#{input}'"
      puts "Expected '#{expected}' but was actually '#{actual}'"
    end
  end

  def read_file(filename)
    File.open(filename).read.strip
  end

  def default_data_file(script_filename)
    basename = File.basename(script_filename).split('.').first

    read_file("data/#{basename}.txt")
  end

  def freq(counts, e)
    counts[e] += 1;
    counts
  end
end
