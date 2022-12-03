file = File.read('./input.txt')
array = file.split("\n")

reference = ' abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

def find_duplicate(part1, part2)
  part1.each_char do |letter|
    return letter if part2.include?(letter)
  end
end

priority_sum = 0
array.each do |rucksack|
  size = rucksack.length / 2
  letter = find_duplicate(rucksack[0..size - 1], rucksack[size..-1])
  priority_sum += reference.rindex(letter)
end

print 'Final sum: ', priority_sum
