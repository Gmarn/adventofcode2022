file = File.read('./input.txt')
array = file.split("\n")
# @stacks, array = file.split("\n\n")

# puts @stacks
# @stacks = {
#   "1" => ["Z", "N"],
#   "2" => ["M", "C", "D"],
#   "3" => ["P"]
# }

@stacks = {
  "1" => ["D", "T", "R", "B", "J", "L", "W", "G"],
  "2" => ["S", "W", "C"],
  "3" => ["R", "Z", "T", "M"],
  "4" => ["D", "T", "C", "H", "S", "P", "V"],
  "5" => ["G", "P", "T", "L", "D", "Z"],
  "6" => ["F", "B", "R", "Z", "J", "Q", "C", "D"],
  "7" => ["S", "B", "D", "J", "M", "F", "T", "R"],
  "8" => ["L", "H", "R", "B", "T", "V", "M"],
  "9" => ["Q", "P", "D", "S", "V"]
}


def crane_movement(from, to)
  output = @stacks[from].pop
  @stacks[to] << output
end

score = 0
array.each do |stack_move|
  moves = stack_move.split(' ')
  moves[1].to_i.times do |i|
    crane_movement(moves[3], moves[5])
  end
end

print 'Result ', @stacks.map { |k, v| v[-1] }.join, "\n"
