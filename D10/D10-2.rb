file = File.read('./input.txt')
array = file.split("\n")

result = [[], [], [], [], [], []]
cycle, x, height =  0, 1, 0

def lit_or_dark(cycle, x)
  return '#' if [x - 1, x, x + 1].include?(cycle)
  '.'
end

array.each do |instruction|
  cmd, value = instruction.split(' ')
  case cmd
  when 'noop'
    result[height] << lit_or_dark(cycle - height * 40, x)
    cycle += 1
    height += 1 if cycle % 40 == 0
  when 'addx'
    2.times do
      result[height] << lit_or_dark(cycle - height * 40, x)
      cycle += 1
      height += 1 if cycle % 40 == 0
    end
    x += value.to_i
  end
end

print 'Result ', "\n"
puts result.map { |e| e.join }
