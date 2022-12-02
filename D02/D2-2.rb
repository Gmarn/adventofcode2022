file = File.read('./input.txt')
array = file.split("\n")

result_points = { X: 0, Y: 3, Z: 6 }
shape_points = { A: 1, B: 2, C: 3 }

def choose_my_shape(opponent, result)
  case opponent
  when 'A'
    case result
    when 'X'
      :C
    when 'Y'
      :A
    when 'Z'
      :B
    end
  when 'B'
    case result
    when 'X'
      :A
    when 'Y'
      :B
    when 'Z'
      :C
    end
  when 'C'
    case result
    when 'X'
      :B
    when 'Y'
      :C
    when 'Z'
      :A
    end
  end
end

score = 0
array.each do |match|
  opponent, result = match.split(' ')
  score += shape_points[choose_my_shape(opponent, result)] + result_points[result.to_sym]
end

print 'Final score: ', score
