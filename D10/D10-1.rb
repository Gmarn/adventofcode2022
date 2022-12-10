file = File.read('./input.txt')
array = file.split("\n")

result, cycle, x = [], 0, 1

array.each do |instruction|
  cmd, value = instruction.split(' ')
  case cmd
  when 'noop'
    cycle += 1
    print 'X: ', x, ' Strenght ', x * cycle, "\n" if (20 + cycle) % 40 == 0
    result << x * cycle if (20 + cycle) % 40 == 0
  when 'addx'
    2.times do
      cycle += 1
      print 'X: ', x, ' Strenght ', x * cycle, "\n" if (20 + cycle) % 40 == 0
      result << x * cycle if (20 + cycle) % 40 == 0
    end
    x += value.to_i
  end
end

print 'Result ', result.sum, "\n"
