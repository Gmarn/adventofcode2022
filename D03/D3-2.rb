file = File.read('./input.txt')
array = file.split("\n")

reference = ' abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

def find_duplicates(part1, part2)
  common_letter = []
  part1.each_char do |letter|
    common_letter << letter if part2.include?(letter)
  end
  common_letter.uniq.join
end

priority_sum = 0
array.each_slice(3) do |group|
  letters = find_duplicates(group[0], group[1])
  letters = find_duplicates(letters, group[2])

  raise StandardError if letters.length > 1

  priority_sum += reference.rindex(letters)
end

print 'Final sum: ', priority_sum, "\n"
