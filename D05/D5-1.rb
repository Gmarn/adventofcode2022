file = File.read('./input.txt')
stacks, array = file.split("\n\n")

stacks = stacks.split("\n").reverse
@stacks = stacks[0].split('   ').each_with_object({}) { |e, acc| acc[e.to_i.to_s] = [] }

stacks[1..-1].each do |line|
  array_line = []
  line.chars.each_slice(4) do |elm|
    array_line << elm.select { |char| char.match? /[A-Z]/ }
  end

  array_line.each_with_index do |e, index|
    next if e.empty?
    @stacks[(index + 1).to_s] << e.first
  end
end

def crane_movement(from, to)
  output = @stacks[from].pop
  @stacks[to] << output
end

score = 0
array.split("\n").each do |stack_move|
  moves = stack_move.split(' ')
  moves[1].to_i.times do |i|
    crane_movement(moves[3], moves[5])
  end
end

print 'Result ', @stacks.map { |k, v| v[-1] }.join, "\n"
