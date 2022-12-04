file = File.read('./input.txt')
array = file.split("\n")

def is_contains(assignement1, assignement2)
  junction = assignement1 & assignement2
  return false if junction.empty?
  true
end

score = 0
array.each do |pair_assignments|
  assignement1, assignement2 = pair_assignments.split(',').map { |e| e.split('-') }
  assignement1 = Array(assignement1[0]..assignement1[1])
  assignement2 = Array(assignement2[0]..assignement2[1])

  score += 1 if is_contains(assignement1, assignement2)
end

print 'Result ', score, "\n"
